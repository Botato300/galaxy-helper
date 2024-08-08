script_name("GalaxyHelper")
script_author("Votati")
script_version("0.1")

require("lib.moonloader")
-- require("lib.sampfuncs")
local sampEvent = require("lib.samp.events")

local Colors = require("lib.GalaxyHelper.colors")
local App = require("lib.GalaxyHelper.app")

function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end

    print("cargado correctamente.")

    -- Commands
    sampRegisterChatCommand("gh", cmd_gh)
    sampRegisterChatCommand("test", cmd_test)

    -- Custom events
    init_event_keyboard()
    init_event_dxut()

    wait(-1)
end

function init_event_keyboard()
    lua_thread.create(function()
        while true do
            if isKeyJustPressed(VK_1) and not sampIsChatInputActive() then cmd_gh() end

            wait(100)

        end
    end)
end

function init_event_dxut()
    lua_thread.create(function()
        while true do
            if MENU_DIALOG then
                local _, event_type, component_id = dxutPopEvent(MENU_DIALOG)

                on_event_dxut(MENU_DIALOG, event_type, component_id)               
            end
            wait(100)
        end
    end)
end

function on_event_dxut(dialog_id, event_type, component_id)
    if dialog_id == MENU_DIALOG then
        -- cuando se clickea un checkbox
        if event_type == 1025 then
            if dxutIsCheckboxChecked(dialog_id, component_id) then
                dxutSetCheckboxColor(dialog_id, component_id, 0xCC7BFC74)
            else
                dxutSetCheckboxColor(dialog_id, component_id, 0xCCFFFFFF)
            end
        end
    
        -- cuando se clickea un boton
        if event_type == 257 then
            if component_id == 12 then
                dxutSetDialogVisible(dialog_id, false)
                sampToggleCursor(false)
            end

            if component_id == 10 then
                dxutSetDialogVisible(dialog_id, false)
                sampToggleCursor(false)
                sampAddChatMessage("Guardaste!", Colors.SUCCESS)
            end
        end
    end

end

function sampEvent.onSetPlayerDrunk(level)
    return false
end

function sampEvent.onDestroyObject(objectid)
    -- sampAddChatMessage(objectid, -1)
    -- return false
end

function sampEvent.onCreateObject(_, object)
    if data.object == 1585 or data.object == 1586 then 
        sampAddChatMessage("no se creo objeto id: " .. data.object, Colors.INFO)
        return false 
    end
end

MENU_DIALOG = nil
function create_dialog_menu()
    MENU_DIALOG = dxutCreateDialog("{FFFFFF}GalaxyHelper")
    dxutSetDialogBackgroundColor(MENU_DIALOG, 0x99000000)
    
    local RES_X, RES_Y = getScreenResolution()
    
    local DIALOG_SIZE_X = 300
    local DIALOG_SIZE_Y = 250
    
    local DIALOG_POS_X = RES_X / 2 - (DIALOG_SIZE_X / 2)
    local DIALOG_POS_Y = RES_Y / 2 - (DIALOG_SIZE_Y / 2)
    
    local BUTTON_SIZE_X = 100
    local BUTTON_SIZE_Y = 30
    
    sampToggleCursor(true)
    
    dxutSetDialogPos(MENU_DIALOG, DIALOG_POS_X, DIALOG_POS_Y, DIALOG_SIZE_X, DIALOG_SIZE_Y)
    
    dxutAddCheckbox(MENU_DIALOG, 1, "Desactivar efecto de borracho", 10, 10, #"Desactivar efecto de borracho"*9, 20)
    dxutSetCheckboxColor(MENU_DIALOG, 1, 0xCCFFFFFF)
    dxutCheckboxSetChecked(MENU_DIALOG, 1)
    
    dxutAddCheckbox(MENU_DIALOG, 2, "Casco Automático", 10, 35, #"Casco Automático"*11, 20)
    dxutCheckboxSetChecked(MENU_DIALOG, 2)
    dxutSetCheckboxColor(MENU_DIALOG, 2, 0xCCFFFFFF)
    
    dxutAddButton(MENU_DIALOG, 12, "X", DIALOG_SIZE_X-18, 0, 15, 15)
    dxutAddButton(MENU_DIALOG, 10, "Guardar", DIALOG_SIZE_X/2 - (BUTTON_SIZE_X/2), DIALOG_SIZE_Y-55, BUTTON_SIZE_X, BUTTON_SIZE_Y)

    dxutSetDialogVisible(MENU_DIALOG, true)
end

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