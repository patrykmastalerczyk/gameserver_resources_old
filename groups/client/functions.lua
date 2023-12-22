prepared_group_list = {}

function prepare_character_group_list(group_list)
    if (group_list and type(group_list) == "table") then
        for _, group in ipairs(group_list) do
            local group_info = {
                id = group.id,
                name = group.name
            }

            table.insert(prepared_group_list, group_info)
        end
    end
end