local callbacks = {}

local sampEvents = require("lib.samp.events")

local App = require("lib.GalaxyHelper.app")
local Colors = require("lib.GalaxyHelper.colors")

function sampEvents.onSetPlayerDrunk(level)
    if App.settings.disable_druken_effect then return false end
end

function sampEvents.onCreateObject(_, object)
    if App.settings.only_red_posters and (object.modelId == 1585 or object.modelId == 1586) then 
        return false 
    end
end

function sampEvents.onMarkersSync(reader, writer)
    -- posible admin spect, aun pendiente
    -- for _, marker in ipairs(reader) do
    --     if marker.active then
    --         sampAddChatMessage(string.format("id: %d", marker.playerId), Colors.INFO)
    --     end
    -- end
end

function sampEvents.onSetCheckpoint(position, radius)
    if App.settings.enable_farmer_bug then 
        if math.floor(position.x) == math.floor(-373.34118652344) and math.floor(position.y) == math.floor(-1428.6010742188) then 
            return
        end

        if math.floor(position.x) ~= math.floor(-310.3219909668) and math.floor(position.y) ~= math.floor(-1344.2666015625) then
            sampSendChat("/borrarcp")
            sampSendChat("/cosechar")
        end
        return {position, radius+1.9} -- se incrementa el radius para hacerlo acorde al tamaño real del checkpoint
    end
end

function sampEvents.onSetPlayerColor(playerid, color)        
    if App.settings.notify_admin_on_duty then
        -- 1241448448 color verde
        -- -52480 color amarillo
        -- -10420224 color rojo anaranjado
        if color == 1241448448 or color == -52480 or color == -10420224 then
            sampAddChatMessage(string.format("[%s]: El admin %s [ID: %d] se puso en servicio.", App.name, sampGetPlayerNickname(playerid), playerid), Colors.WARNING)
        end
    end
end

function callbacks.init()
    print("[INFO]: Modulo de callbacks de sa-mp cargado.")
end

return callbacks