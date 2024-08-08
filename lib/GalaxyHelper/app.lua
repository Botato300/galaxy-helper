local app = {
    name = "GalaxyHelper",
    config = {
        put_belt = false
    }
}

function app.config.save()
    print("guardado!")
end

function app.config.load()
    print("cargado!")
end

return app