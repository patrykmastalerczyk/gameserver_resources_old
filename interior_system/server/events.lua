addEvent("on_player_interior_change", true)
addEventHandler("on_player_interior_change", root, function(player, interior_id, action_type)
    if (action_type and type(action_type) == "string") then
        if (action_type == "entrance") then
            local exit_x, exit_y, exit_z = get_interior_data(interior_id, "exit_x"), get_interior_data(interior_id, "exit_y"), get_interior_data(interior_id, "exit_z")
            local exit_dimension = get_interior_data(interior_id, "exit_dimension")

            setElementDimension(player, exit_dimension)
            setElementPosition(player, exit_x, exit_y, exit_z)

            outputChatBox("wchodzisz")
            outputChatBox(tostring(string.format("twoj dim to teraz: %d", getElementDimension(player))))
        elseif (action_type == "exit") then
            local entrance_x, entrance_y, entrance_z = get_interior_data(interior_id, "entrance_x"), get_interior_data(interior_id, "entrance_y"), get_interior_data(interior_id, "entrance_z")
            local entrance_dimension = get_interior_data(interior_id, "entrance_dimension")

            setElementDimension(player, entrance_dimension)
            setElementPosition(player, entrance_x, entrance_y, entrance_z)

            outputChatBox(tostring(string.format("twoj dim to teraz: %d", getElementDimension(player))))
            outputChatBox("wychodzisz")
        end
    end
end)