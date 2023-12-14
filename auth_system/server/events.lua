addEvent("validate_player_credentials", true)
addEventHandler("validate_player_credentials", root, function(player, username, password)
    if (player and getElementType(player) == "player" and username and type(username) == "string" and password and type(password) == "string") then
        local player_data = exports.db_system:db_query("SELECT * FROM `players` WHERE `username` = ? LIMIT 1", username)

        if (player_data) then
            local hashed_password = player_data[1]["password"]
    
            if (hashed_password) then
                local password_match = passwordVerify(password, hashed_password)
    
                if (password_match) then
                    assign_player_data(player, player_data)
                else
                    triggerClientEvent(player, "invalid_data", player, "password")
                end
            end
        else
            triggerClientEvent(player, "invalid_data", player, "username")
        end
    end
end)

addEvent("validate_player_character", true)
addEventHandler("validate_player_character", root, function(player, character_id)
    if (player and getElementType(player) == "player" and character_id and type(character_id) == "number") then
        local player_id = getElementData(player, "id")
        local player_name = getElementData(player, "name")

        if (player_id and player_name) then -- check if the player owns the character
            local character_data = exports.db_system:db_query("SELECT * FROM `characters` WHERE `id` = ? AND `owner_id` = ?", character_id, player_id)
    
            if (character_data) then
                assign_player_character_data(player, character_id, character_data)
            end
        end
    end
end)