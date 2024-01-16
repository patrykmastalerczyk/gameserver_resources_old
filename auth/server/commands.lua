addCommandHandler("account", function(player, command_name, ...)
    local args = {...}

    if (args[1] == "login") then
        if (args[2] and args[3]) then
            local username = tostring(args[2])
            local password = tostring(args[3])

            validate_player_credentials(player, username, password)
        end
    end
end)

addCommandHandler("character", function(player, command_name, ...)
    local args = {...}

    if (args[1]) then
        local selected_char = tonumber(args[1])

        validate_player_character(player, selected_char)
    end
end)