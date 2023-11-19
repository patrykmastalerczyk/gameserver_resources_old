function load_interior_list()
    local interior_list = exports.db_system:db_query("SELECT * FROM `interiors`")

    if (interior_list) then
        local interior_id = nil

        for _, interior in ipairs(interior_list) do
            interior_id = interior["id"]

            set_interior_data(interior_id, "title", interior["title"])
            set_interior_data(interior_id, "description", interior["description"])
            set_interior_data(interior_id, "owner_id", interior["owner_id"])
            set_interior_data(interior_id, "owner_type", interior["owner_type"])
            set_interior_data(interior_id, "entrance_x", interior["entrance_x"])
            set_interior_data(interior_id, "entrance_y", interior["entrance_y"])
            set_interior_data(interior_id, "entrance_z", interior["entrance_z"])
            set_interior_data(interior_id, "exit_x", interior["exit_x"])
            set_interior_data(interior_id, "exit_y", interior["exit_y"])
            set_interior_data(interior_id, "exit_z", interior["exit_z"])
            set_interior_data(interior_id, "entrance_dimension", interior["entrance_dimension"])
            set_interior_data(interior_id, "exit_dimension", interior["exit_dimension"])

            set_interior_position(interior_id)
        end
    end
end

function set_interior_position(interior_id)
    if (interior_id and type(interior_id) == "number") then
        local entrance_x = get_interior_data(interior_id, "entrance_x")
        local entrance_y = get_interior_data(interior_id, "entrance_y")
        local entrance_z = get_interior_data(interior_id, "entrance_z")

        local entrance_dimension = get_interior_data(interior_id, "entrance_dimension")

        if (entrance_x and entrance_y and entrance_z and entrance_dimension) then
            local entrance_marker = createMarker(entrance_x, entrance_y, entrance_z - 1, "cylinder", 1.0, 255, 255, 255, 25, root)
            setElementData(entrance_marker, "interior_id", interior_id)
            setElementDimension(entrance_marker, entrance_dimension)

            local exit_x = get_interior_data(interior_id, "exit_x")
            local exit_y = get_interior_data(interior_id, "exit_y")
            local exit_z = get_interior_data(interior_id, "exit_z")

            local exit_dimension = get_interior_data(interior_id, "exit_dimension")

            if (exit_x and exit_y and exit_z and exit_dimension) then
                local exit_marker = createMarker(exit_x, exit_y, exit_z - 1, "cylinder", 1.0, 255, 255, 255, 25, root)
                setElementData(exit_marker, "interior_id", interior_id)
                setElementDimension(exit_marker, exit_dimension)
            end
        end
    end
end