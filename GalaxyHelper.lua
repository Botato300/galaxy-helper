local App = require("lib.GalaxyHelper.app")
local Events = require("lib.GalaxyHelper.events")
local Callbacks = require("lib.GalaxyHelper.callbacks")
local Commands = require("lib.GalaxyHelper.commands")

script_name("GalaxyHelper")
script_author("Votati")
script_version("0.1")

function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
    
    print("[INFO]: Modulo principal cargado correctamente.")
    
    App.config.load()

    -- Commands
    sampRegisterChatCommand("gh", Commands.cmd_gh)
    sampRegisterChatCommand("test", Commands.cmd_test)

    -- Custom events
    Events.init()

    -- SA-MP callbacks
    Callbacks.init()

    wait(-1)
end