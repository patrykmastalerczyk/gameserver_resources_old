addEvent("on_player_request_character_group_list", true)
addEventHandler("on_player_request_character_group_list", root, function(player)
    if (player and getElementType(player) == "player") then
        local character_id = exports.auth_system:get_character_id(player)

        if (character_id and type(character_id) == "number") then
            local character_groups = exports.db_system:db_query("SELECT * FROM group_members WHERE member_id = ?", character_id)
    
            if (character_groups and type(character_groups) == "table") then
                triggerClientEvent(player, "on_player_receive_character_group_list", player, character_groups)
            end
        end
    end
end)

addEvent("on_player_request_duty_state_change", true)
addEventHandler("on_player_request_duty_state_change", root, function(character_id, group_id)
    local service_status = exports.auth_system:get_character_data(character_id, "current_group_id")

    if (service_status) then
        exports.auth_system:remove_character_data(character_id, "current_group_id")

        return outputChatBox("Zchodzisz ze służby grupy.")
    end

    exports.auth_system:set_character_data(character_id, "current_group_id", group_id)
    outputChatBox(tostring(exports.auth_system:get_character_data(character_id, "current_group_id")))

    outputChatBox("Wchodzisz na służbę grupy.")
end)