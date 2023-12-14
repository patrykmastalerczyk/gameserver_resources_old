group_list = {}

addEventHandler("onClientResourceStart", resourceRoot, function()
    initialize_character_group_list()
end) -- test purposes

addEvent("on_player_receive_character_group_list", true)
addEventHandler("on_player_receive_character_group_list", root, function(character_groups)
    for _, group in ipairs(character_groups) do
        table.insert(group_list, group)
    end
end)

