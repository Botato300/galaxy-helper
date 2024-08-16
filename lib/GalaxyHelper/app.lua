local inicfg = require("inicfg")

local app = {
    name = "GalaxyHelper",
    version = "0.1",
    config = {},
    settings = {
        disable_druken_effect = false,
        only_red_posters = false,
        notify_admin_on_duty = false,
    },
    setting_names = {
        disable_druken_effect = "disable_druken_effect",
        only_red_posters = "only_red_posters",
        notify_admin_on_duty = "notify_admin_on_duty",
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

    if loaded_cfg.settings then
        loaded_cfg = loaded_cfg.settings
    end

    app.settings = loaded_cfg
end

return app