     getServerSetting = function(server)
        local options = { }
        local require_ok, settings = pcall(require, 'lspsettings' .. server)
        if require_ok then
            options.settings = settings
        end
        return options
    end

