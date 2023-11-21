function set_interiors_position(interior_list)
    if (interior_list and type(interior_list) == "table") then
        for _, interior in ipairs(interior_list) do
            local interior_id = interior["id"]
    
            if (interior_id) then
                local entrance_x, entrance_y, entrance_z = interior["entrance_x"], interior["entrance_y"], interior["entrance_z"]
                local entrance_dimension = interior["entrance_dimension"]
    
                if (entrance_x and entrance_y and entrance_z and entrance_dimension) then
                    local entrance_marker = createMarker(entrance_x, entrance_y, entrance_z, "cylinder", 1.0, 255, 255, 255, 50)
            
                    if (entrance_marker) then
                        setElementData(entrance_marker, "interior_id", interior_id)
                        setElementDimension(entrance_marker, entrance_dimension)
    
                        local exit_x, exit_y, exit_z = interior["exit_x"], interior["exit_y"], interior["exit_z"]
                        local exit_dimension = interior["exit_dimension"]
    
                        if (exit_x and exit_y and exit_z and exit_dimension) then
                            local exit_marker = createMarker(exit_x, exit_y, exit_z, "cylinder", 1.0, 255, 255, 255, 50)
    
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