local events = {}

local vkeys = require("vkeys")

local App = require("lib.GalaxyHelper.app")
local Dialog = require("lib.GalaxyHelper.dialogs")
local Commands = require("lib.GalaxyHelper.commands")
local Colors = require("lib.GalaxyHelper.colors")

local settings_menu = {
    [1] = App.setting_names.disable_druken_effect,
    [2] = App.setting_names.put_helmet,
}

local DXUT_EVENTS = {
    CLICKED_CHECKBOX = 1025,
    CLICKED_BUTTON = 257,
}

local handlers_components = {

}

local function on_event_dxut(dialog_id, event_type, component_id)
    if dialog_id == Dialog.MENU.dialog_id then
        if event_type == DXUT_EVENTS.CLICKED_CHECKBOX then
            -- falta manejar mejor las acciones para los checkbox, tal cual se hizo con los botones
            local is_checked = dxutIsCheckboxChecked(dialog_id, component_id)

            App.settings[settings_menu[component_id]] = is_checked
            dxutSetCheckboxColor(dialog_id, component_id, is_checked and 0xCC7BFC74 or 0xCCFC7474)
            dxutCheckboxSetChecked(dialog_id, component_id, is_checked)
        end
    
        if event_type == DXUT_EVENTS.CLICKED_BUTTON then
            if Dialog.MENU.components[component_id] then
                Dialog.MENU.components[component_id].action(dialog_id)
            else
                print("[WARNING]: Hay un boton no registrado para el evento del dialogo.")
            end
            
            if component_id == 10  or component_id == 12 then
                dxutSetDialogVisible(dialog_id, false)
                sampToggleCursor(false)
            end

        end
    end
end

local function update_event_keyboard()
    if (isKeyJustPressed(vkeys.VK_1) and isKeyJustPressed(vkeys.VK_LSHIFT)) and not sampIsChatInputActive() then Commands.cmd_gh() end
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