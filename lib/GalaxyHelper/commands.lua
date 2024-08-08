local Dialog = require("dialogs")

function cmd_gh()
    if not MENU_DIALOG then
        create_dialog_menu()
        return
    end

    dxutSetDialogVisible(MENU_DIALOG, not dxutIsDialogVisible(MENU_DIALOG))
    sampToggleCursor(dxutIsDialogVisible(MENU_DIALOG))
end

function cmd_test()
    -- setPlayerDrunkenness(PLAYER_HANDLE, 0)
    -- sampAddChatMessage("borrachera en 0!", Colors.GENERAL)

    -- App.config.save()

    clearWantedLevel(PLAYER_HANDLE)
end