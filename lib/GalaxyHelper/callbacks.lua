local callbacks = {}

local sampEvents = require("samp.events")

local App = require("lib.GalaxyHelper.app")
local Colors = require("lib.GalaxyHelper.colors")

function sampEvents.onSetPlayerDrunk(level)
    -- activar si la opcion esta marcada
    return false
end

function sampEvents.onDestroyObject(objectid)
    -- sampAddChatMessage("obj destruido: " .. objectid, Colors.INFO)
    -- if objectid == 31 or objectid == 30 then 
    --     return false
    -- end
end

function sampEvents.onCreateObject(_, object)
    -- if object.modelId == 1585 or object.modelId == 1586 then 
    --     sampAddChatMessage("no se creo objeto id: " .. object.modelId, Colors.INFO)
    --     return false 
    -- end
end

function sampEvents.onMarkersSync(reader, writer)
    -- for _, marker in ipairs(reader) do
    --     if marker.active and marker.playerId ~= 12 then
    --         sampAddChatMessage(string.format("id: %d | actived: %s", marker.playerId, tostring(marker.active)), Colors.INFO)
    --     end
    -- end
end

function sampEvents.onSetCheckpoint(position, radius)
    -- local posX, posY, posZ = getCharCoordinates(PLAYER_PED)

    -- position.z = position.z + 5

    -- return {position, radius}
end

function sampEvents.onSetPlayerSkillLevel(playerid, skill, level)
    -- return false
end

function sampEvents.onSetPlayerColor(playerid, color)
    local new_color = sampGetPlayerColor(playerid)
    if new_color == Colors.admin.normal or new_color == Colors.admin.top then
        sampAddChatMessage(string.format("[%s]: El admin %s [ID: %d] se puso en servicio.", App.name, sampGetPlayerNickname(playerid), playerid), Colors.WARNING)
    end
end

function callbacks.init()
    print("[INFO]: Modulo de callbacks de sa-mp cargado.")
end

return callbacks