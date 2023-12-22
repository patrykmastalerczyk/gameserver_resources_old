addCommandHandler("group", function(command_name, ...)
    local args = {...}

    local group_slot = tonumber(args[1])
    
    if (prepared_group_list[group_slot]) then
        local group_action = tostring(args[2])

        if (group_action == "duty") then
            local group_id = prepared_group_list[group_slot]["id"]
            local group_name = prepared_group_list[group_slot]["name"]

            local group_data = {
                id = group_id,
                name = group_name
            }

            return triggerServerEvent("on_player_request_character_duty_status_change", localPlayer, localPlayer, group_data)
        end
    end

    return outputChatBox("Nie posiadasz grupy we wskazanym slocie.")
end)