local events = {}

local vkeys = require("vkeys")

local App = require("lib.GalaxyHelper.app")
local Dialog = require("lib.GalaxyHelper.dialogs")
local Commands = require("lib.GalaxyHelper.commands")
local Colors = require("lib.GalaxyHelper.colors")

local DXUT_EVENTS = {
    CLICKED_CHECKBOX = 1025,
    CLICKED_BUTTON = 257,
}

local function on_event_dxut(dialog_id, event_type, component_id)
    if dialog_id == Dialog.MENU.dialog_id then
        if event_type == DXUT_EVENTS.CLICKED_CHECKBOX then
            if not Dialog.MENU.components[component_id] then
                print("[WARNING]: Hay un checkbox no registrado para el evento del dialogo.")
                return
            end
            
            Dialog.MENU.components[component_id].action(dialog_id, component_id)
        end
    
        if event_type == DXUT_EVENTS.CLICKED_BUTTON then
            if not Dialog.MENU.components[component_id] then
                print("[WARNING]: Hay un boton no registrado para el evento del dialogo.")
                return
            end
            
            Dialog.MENU.components[component_id].action(dialog_id)
        end
    end
end

local function update_event_keyboard()
    if (isKeyJustPressed(vkeys.VK_1) and isKeyJustPressed(vkeys.VK_LSHIFT)) and not sampIsChatInputActive() then Commands.cmd_gh() end

    -- if isKeyJustPressed(vkeys.VK_LEFT) and not sampIsChatInputActive() and not sampIsDialogActive() then
    --     sampSendChat("/ver guantera")
    -- end
    -- if isKeyJustPressed(vkeys.VK_RIGHT) and not sampIsChatInputActive() and not sampIsDialogActive() then
    --     sampSendChat("/vender arma 33 5000")
    -- end

    -- if isKeyJustPressed(vkeys.VK_DOWN) and not sampIsChatInputActive() and not sampIsDialogActive() then
    --     sampSendChat("/borrarcp")
    -- end
    -- if isKeyJustPressed(vkeys.VK_UP) and not sampIsChatInputActive() and not sampIsDialogActive() then
    --     sampSendChat("/cosechar")
    -- end
end

local function update_event_dxut()
    if Dialog.MENU then
        local _, event_type, component_id = dxutPopEvent(Dialog.MENU.dialog_id)

        on_event_dxut(Dialog.MENU.dialog_id, event_type, component_id)               
    end
end

function events.init()
    lua_thread.create(function()
        while true do
            update_event_keyboard()

            update_event_dxut()

            wait(100)
        end
    end)
end

return events