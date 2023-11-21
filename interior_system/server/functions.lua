function load_interiors()
    local interior_data = exports.db_system:db_query("SELECT * FROM `interiors`")

    if (interior_data) then
        for _, interior in ipairs(interior_data) do
            local interior_id = interior["id"]

            if (interior_id) then
                set_interior_data(interior_id, "id", interior_id)
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
            end
        end
    end
end