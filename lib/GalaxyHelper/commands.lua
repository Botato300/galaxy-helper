local Dialog = require("lib.GalaxyHelper.dialogs")
local Colors = require("lib.GalaxyHelper.colors")
local App = require("lib.GalaxyHelper.app")

local commands = {}

function commands.cmd_gh()
    if not Dialog.MENU then
        Dialog.create_menu()
        return
    end

    dxutSetDialogVisible(Dialog.MENU.dialog_id, not dxutIsDialogVisible(Dialog.MENU.dialog_id))
    sampToggleCursor(dxutIsDialogVisible(Dialog.MENU.dialog_id))
end

function commands.cmd_test(arg)
    
end

return commands