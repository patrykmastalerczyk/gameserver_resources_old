addCommandHandler("log", function(player, command_name, ...)
    local args = {...}

    if (args[1] and args[2]) then
        local username = tostring(args[1])
        local password = tostring(args[2])

        validate_player_credentials(player, username, password)
    end
end)

addCommandHandler("char", function(player, command_name, ...)
    local args = {...}

    if (args[1]) then
        local selected_char = tonumber(args[1])

        validate_player_character(player, selected_char)
    end
end)