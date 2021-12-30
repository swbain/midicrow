-- converts incoming midi to 
-- crow cv out
--
-- crow out 1: pitch v/oct

local function init_midi()
    for _, device in pairs(midi.devices) do
        if device.port ~= nil then
            local device = midi.connect(device.port)
            device.event = function (data)
                local d = midi.to_msg(data)
                if d.type == "note_on" then
                    print(d.note)
                    crow.output[1].volts = (d.note - 60) / 12
                end
            end
        end
    end
end

function init()
    init_midi()
end
