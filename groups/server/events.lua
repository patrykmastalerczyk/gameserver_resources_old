addEvent("on_player_request_character_duty_status_change", true)
addEventHandler("on_player_request_character_duty_status_change", root, function(player, group_data)
    if (player and getElementType(player) == "player") then
        if (group_data and type(group_data) == "table") then
            local character_id = exports.auth:get_player_character_id(player)

            if (character_id) then
                local group_id = group_data["id"]

                if (group_id) then
                    update_character_duty_status(character_id, group_data)
                end
            end
        end
    end
end)