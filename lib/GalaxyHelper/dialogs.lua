local App = require("lib.GalaxyHelper.app")
local Colors = require("lib.GalaxyHelper.colors")
local Layout = require("lib.GalaxyHelper.layout")

local dialog = {
    MENU = nil,
}

function callback_close_dialog(dialog_id)
    dxutSetDialogVisible(dialog_id, false)
    sampToggleCursor(false)
end

function callback_save_config(dialog_id)
    App.config.save()
    sampAddChatMessage(string.format("[%s]: ¡Guardado!", App.name), Colors.SUCCESS)
    callback_close_dialog(dialog_id)
end

function toggle_setting(dialog_id, component_id)
    local setting_name = dialog.MENU.components[component_id].setting_name
    local is_checked = dxutIsCheckboxChecked(dialog_id, component_id)

    App.settings[setting_name] = is_checked
    dxutSetCheckboxColor(dialog_id, component_id, is_checked and 0xCC7BFC74 or 0xCCFC7474)
    dxutCheckboxSetChecked(dialog_id, component_id, is_checked)
end

function dialog.create_menu()
    dialog.MENU = Layout:new("Menú", 500, 270)

    dialog.MENU:create_checkbox("Desactivar efecto de borracho", App.setting_names.disable_druken_effect, toggle_setting)
    dialog.MENU:create_checkbox("Spawnear solo carteles rojo en la Academia de Disparo", App.setting_names.only_red_posters, toggle_setting)
    dialog.MENU:create_checkbox("Notificar cuando un admin se pone en servicio", App.setting_names.notify_admin_on_duty, toggle_setting)

    dialog.MENU:create_button("Guardar", nil, dialog.MENU.DIALOG_SIZE_Y - 50, callback_save_config)

    dxutSetDialogVisible(dialog.MENU.dialog_id, true)
    sampToggleCursor(true)
end


return dialog