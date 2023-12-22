function request_character_group_list(player)
    if (player) then
        local character_id = exports.auth:get_player_character_id(player)

        if (character_id) then
            local group_list = exports.database:execute_query("SELECT groups.id, groups.name FROM group_members JOIN groups ON group_members.group_id = groups.id WHERE group_members.member_id = ?", character_id)

            if (group_list) then
                triggerClientEvent(player, "on_player_receive_character_group_list", player, group_list)
            end
        end
    end
end

function update_character_duty_status(character_id, group_data)
    if (character_id and group_data) then
        local group_id = group_data["id"]
        local group_name = group_data["name"]

        local current_group_id = exports.auth:get_character_data(character_id, "current_group_id")

        if (current_group_id) then
            local minutes, seconds = calculate_duty_time(character_id)

            exports.auth:remove_character_data(character_id, "current_group_id")
            return outputChatBox(string.format("Kończysz pracę w grupie %s. Przepracowałeś %d minut i %d sekund.", group_name, minutes, seconds))
        end
        
        exports.auth:set_character_data(character_id, "current_group_id", group_id)

        local start_time = getTickCount()
        exports.auth:set_character_data(character_id, "duty_start_time", start_time)

        return outputChatBox(string.format("Rozpoczynasz pracę w grupie %s.", group_name))
    end
end

function calculate_duty_time(character_id)
    local end_time = getTickCount()

    local start_time = exports.auth:get_character_data(character_id, "duty_start_time")
    local duty_time = end_time - start_time

    local duty_seconds = duty_time / 1000

    local remaining_minutes = math.floor(duty_seconds / 60)
    local remaining_seconds = duty_seconds % 60

    return remaining_minutes, remaining_seconds
end