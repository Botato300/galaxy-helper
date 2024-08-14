local inicfg = require("inicfg")

local app = {
    name = "GalaxyHelper",
    version = "0.1",
    config = {},
    settings = {
        disable_druken_effect = false,
        put_helmet = false
    },
    setting_names = {
        disable_druken_effect = "disable_druken_effect",
        put_helmet = "put_helmet",
    }
}

function app.config.save()
    local formatted_settings = {
        settings = {}
    }

    for key, value in pairs(app.settings) do
        if type(value) ~= "table" then
            if type(value) == "boolean" then
                formatted_settings.settings[key] = tostring(value)
            else
                formatted_settings.settings[key] = tostring(value)
            end
        end
    end

    inicfg.save(formatted_settings, "GalaxyHelper")
end

function app.config.load()
    print("[INFO]: Configuracion cargada.")
    local loaded_cfg = inicfg.load(app.settings, "GalaxyHelper")
    -- app.settings = loaded_cfg.settings
    for k, v in pairs(loaded_cfg.settings) do
        app.settings[k] = v
    end
end

return app