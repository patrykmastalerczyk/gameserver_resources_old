addCommandHandler("log", function(player, command_name, ...)
    local logged_in = get_player_data(player, "logged_in")

    if (not logged_in) then
        local args = {...}

        if (args[1] and args[2]) then
            local username = tostring(args[1])
            local password = tostring(args[2])

            validate_player_credentials(player, username, password)
        end
    else
        outputChatBox("Jesteś już zalogowany.")
    end
end)

addCommandHandler("char", function(player, command_name, ...)
    local character_id = get_player_data(player, "character_id")

    if (not character_id) then
        local args = {...}

        if (args[1]) then
            local selected_char = tonumber(args[1])

            validate_player_character(player, selected_char)
        end
    else
        outputChatBox("Postać jest już wybrana.")
    end
end)