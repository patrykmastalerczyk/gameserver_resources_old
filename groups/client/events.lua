addEvent("on_player_receive_character_group_list", true)
addEventHandler("on_player_receive_character_group_list", root, function(group_list)
    prepare_character_group_list(group_list)
end)