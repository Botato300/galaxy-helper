local callback = require("../samp.events")

function callback.onSetPlayerDrunk(level)
    return false
end

function callback.onDestroyObject(objectid)
    -- sampAddChatMessage(objectid, -1)
    -- return false
end

function callback.onCreateObject(_, object)
    if data.object == 1585 or data.object == 1586 then 
        sampAddChatMessage("no se creo objeto id: " .. data.object, Colors.INFO)
        return false 
    end
end