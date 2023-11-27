addEventHandler("onResourceStart", resourceRoot, function()
    initialize_interior_data()
end)

addEvent("on_player_request_interior_change", true)
addEventHandler("on_player_request_interior_change", root, function(player, interior_marker)
    if (player and getElementType(player) == "player") then
        if (interior_marker and getElementType(interior_marker) == "marker") then
            local interior_id = getElementData(interior_marker, "interior_id")

            if (interior_id) then
                change_player_interior(player, interior_id, interior_marker)
            end
        end
    end
end)

addCommandHandler("addint", function(player, command)
    local x, y, z = getElementPosition(player)
    local dimension = getElementDimension(player)
    exports.db_system:db_exec("INSERT INTO `interiors` (title, description, entrance_x, entrance_y, entrance_z, exit_x, exit_y, exit_z, entrance_dimension, exit_dimension) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", "Costa Coffee", "Najlepsza kawa w mieście. Zapraszamy!", x, y, z, x, y, z, dimension, dimension + 1)
end)

addCommandHandler("addp", function(player, command)
    local username = "test"
    local password = "123"
    local hashed_password = passwordHash(password, "bcrypt", {})

    exports.db_system:db_exec("INSERT INTO `players` (username, password) VALUES (?, ?)", username, hashed_password)
end)





