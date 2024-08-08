local vkeys = require("../vkeys")

function init_event_keyboard()
    lua_thread.create(function()
        while true do
            if isKeyJustPressed(ml.VK_1) and not sampIsChatInputActive() then cmd_gh() end

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