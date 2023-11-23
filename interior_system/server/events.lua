addEventHandler("onResourceStart", resourceRoot, function()
    initialize_interior_data()
end)

addEvent("on_player_request_interior_change", true)
addEventHandler("on_player_request_interior_change", root, function(player, interior_marker)
    local interior_id = getElementData(interior_marker, "interior_id")

    if (interior_id) then
        local interior_data = get_interior_data(interior_id)

        if (interior_data) then
            local action_type = getElementData(interior_marker, "action_type")

            if (action_type and action_type == "enter") then
                local exit_x, exit_y, exit_z = interior_data["exit_x"], interior_data["exit_y"], interior_data["exit_z"]
                local exit_dimension = interior_data["exit_dimension"]

                if (exit_x and exit_y and exit_z and exit_dimension) then
                    setElementPosition(player, exit_x, exit_y, exit_z)
                    setElementDimension(player, exit_dimension)

                    outputChatBox(string.format("Zmieniono interior na: %d [dim: %d]", interior_id, exit_dimension))

                    outputChatBox(string.format("Wejście na: %f, %f, %f", exit_x, exit_y, exit_z))
                end
            elseif (action_type and action_type == "exit") then
                local entrance_x, entrance_y, entrance_z = interior_data["entrance_x"], interior_data["entrance_y"], interior_data["entrance_z"]
                local entrance_dimension = interior_data["entrance_dimension"]


                if (entrance_x and entrance_y and entrance_z and entrance_dimension) then
                    setElementPosition(player, entrance_x, entrance_y, entrance_z)
                    setElementDimension(player, entrance_dimension)

                    outputChatBox(string.format("Zmieniono interior na: %d [dim: %d]", interior_id, entrance_dimension))

                    outputChatBox(string.format("Wyjście na: %f, %f, %f", entrance_x, entrance_y, entrance_z))
                end
            end
        end
    end
end)


-- id
-- title/name
-- desc
-- type [np. sklep całodobowy/apteka/garaż/dom]
-- owner_id [np. id_osoby/id_grupy]
-- owner_type [np. nikt/osoba/grupa]
-- ent_x, ent_y, ent_z
-- ex_x, ex_y, ex_z
-- ent_dim
-- ex_dim
-- vehicle_entry
-- ent_fee [np. 0/100/3000]
-- rent [np. 800 płatne co miesiąc]

addCommandHandler("addint", function(player, command)
    local x, y, z = getElementPosition(player)
    local dimension = getElementDimension(player)
    exports.db_system:db_exec("INSERT INTO `interiors` (title, description, entrance_x, entrance_y, entrance_z, exit_x, exit_y, exit_z, entrance_dimension, exit_dimension) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", "Costa Coffee", "Najlepsza kawa w mieście. Zapraszamy!", x, y, z, x, y, z, dimension, dimension + 1)
end)




