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
    sampAddChatMessage(string.format("[%s]: ¡Guardado!", App.name), Colors.SUCCESS)
    App.config.save()
    callback_close_dialog(dialog_id)
end

function dialog.create_menu()
    dialog.MENU = Layout:new("Menú", 300, 270)

    dialog.MENU:create_checkbox("Desactivar efecto de borracho", App.setting_names.disable_druken_effect)
    dialog.MENU:create_checkbox("Poner casco automáticamente", App.setting_names.put_helmet)

    dialog.MENU:create_button("Guardar", nil, dialog.MENU.DIALOG_SIZE_Y - 50, callback_save_config)

    dxutSetDialogVisible(dialog.MENU.dialog_id, true)
    sampToggleCursor(true)
end


return dialog