function initialize_interior_data()
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

        -- create interior markers and assign them to specified interior
        create_interior_markers(interior_data)
    end
end

function create_interior_markers(interior_list)
    if (interior_list and type(interior_list) == "table") then
        for _, interior in ipairs(interior_list) do
            local interior_id = interior["id"]
    
            if (interior_id) then
                local entrance_x, entrance_y, entrance_z = interior["entrance_x"], interior["entrance_y"], interior["entrance_z"]
                local entrance_dimension = interior["entrance_dimension"]
    
                if (entrance_x and entrance_y and entrance_z and entrance_dimension) then
                    local entrance_marker = createMarker(entrance_x, entrance_y, entrance_z - 1, "cylinder", 1.0, 255, 255, 255, 0)
            
                    if (entrance_marker) then
                        setElementData(entrance_marker, "interior_id", interior_id)
                        setElementDimension(entrance_marker, entrance_dimension)
    
                        local exit_x, exit_y, exit_z = interior["exit_x"], interior["exit_y"], interior["exit_z"]
                        local exit_dimension = interior["exit_dimension"]
    
                        if (exit_x and exit_y and exit_z and exit_dimension) then
                            local exit_marker = createMarker(exit_x, exit_y, exit_z + 1, "cylinder", 1.0, 255, 0, 0, 0)
    
                            if (exit_marker) then
                                setElementData(exit_marker, "interior_id", interior_id)
                                setElementDimension(exit_marker, exit_dimension)
                            end
                        end
                    end
                end
            end
        end
    end
end