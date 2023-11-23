local interior_list = {}

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

function update_interior_list(received_interior_list)
    if (received_interior_list) then
        interior_list = received_interior_list
    end
end