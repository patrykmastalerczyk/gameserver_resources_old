local interior_list = {}

function set_interior_data(id, data, value)
    if (id and type(id) == "number" and data and type(data) == "string" and value) then
        if (interior_list[id] == nil) then
            interior_list[id] = {}
        end

        interior_list[id][tostring(data)] = value
    end
end

function get_interior_data(id, data)
    if (id and type(id) == "number") then
        if (interior_list[id]) then
            if (data and type(data) == "string") then
                local data_obtained = interior_list[id][data]

                if (data_obtained) then
                    return data_obtained
                end
            else
                local data_obtained = interior_list[id]
                
                if (data_obtained) then
                    return data_obtained
                end
            end
        end
    end

    return nil
end

function get_interior_list()
    return interior_list
end