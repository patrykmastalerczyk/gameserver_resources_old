addCommandHandler("group", function(player, command_name, ...)
    local character_id = exports.auth:get_player_data(player, "character_id")

    if (character_id) then
        local group_list = exports.auth:get_character_data(character_id, "group_list")

        if (group_list) then
            local args = {...}
            local group_slot = tonumber(args[1])

            if (group_list[group_slot]) then
                local group_action = tostring(args[2])

                if (group_action == "duty") then
                    update_character_current_group(character_id, group_list[group_slot])
                end
            end
        end
    end
end)