addEventHandler("onResourceStart", resourceRoot, function()
    local group_list = exports.database:execute_query("SELECT id FROM groups")
    
    if (group_list) then
        for _, group in ipairs(group_list) do
            local group_id = group["id"]

            set_group_data(group_id, "online", 0)
        end
    end
end)

addEventHandler("onResourceStop", resourceRoot, function()
    save_character_group_data()
end)
