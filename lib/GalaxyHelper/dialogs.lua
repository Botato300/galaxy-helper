local dialog = {
    MENU = nil,
}


function dialog.create_dialog_menu()
    dialog.MENU = dxutCreateDialog("{FFFFFF}GalaxyHelper")
    dxutSetDialogBackgroundColor(dialog.MENU, 0x99000000)
    
    local RES_X, RES_Y = getScreenResolution()
    
    local DIALOG_SIZE_X = 300
    local DIALOG_SIZE_Y = 250
    
    local DIALOG_POS_X = RES_X / 2 - (DIALOG_SIZE_X / 2)
    local DIALOG_POS_Y = RES_Y / 2 - (DIALOG_SIZE_Y / 2)
    
    local BUTTON_SIZE_X = 100
    local BUTTON_SIZE_Y = 30
    
    sampToggleCursor(true)
    
    dxutSetDialogPos(dialog.MENU, DIALOG_POS_X, DIALOG_POS_Y, DIALOG_SIZE_X, DIALOG_SIZE_Y)
    
    dxutAddCheckbox(dialog.MENU, 1, "Desactivar efecto de borracho", 10, 10, #"Desactivar efecto de borracho"*9, 20)
    dxutSetCheckboxColor(dialog.MENU, 1, 0xCCFFFFFF)
    dxutCheckboxSetChecked(dialog.MENU, 1)
    
    dxutAddCheckbox(dialog.MENU, 2, "Casco Automático", 10, 35, #"Casco Automático"*11, 20)
    dxutCheckboxSetChecked(dialog.MENU, 2)
    dxutSetCheckboxColor(dialog.MENU, 2, 0xCCFFFFFF)
    
    dxutAddButton(dialog.MENU, 12, "X", DIALOG_SIZE_X-18, 0, 15, 15)
    dxutAddButton(dialog.MENU, 10, "Guardar", DIALOG_SIZE_X/2 - (BUTTON_SIZE_X/2), DIALOG_SIZE_Y-55, BUTTON_SIZE_X, BUTTON_SIZE_Y)

    dxutSetDialogVisible(dialog.MENU, true)
end


return dialog