addCommandHandler("group", function(command_name, ...)
    local args = {...}

    local group_slot = tonumber(args[1])
    local action = args[2]

    if (group_slot and type(group_slot) == "number") then
        if (action == "duty") then
            local group_id = group_list[group_slot]["group_id"]
            toggle_character_service_status(group_id)
        end
    end
end)