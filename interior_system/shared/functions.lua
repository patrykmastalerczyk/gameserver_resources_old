local interior_data = {}

function set_interior_data(id, data, value)
    if (id and type(id) == "number" and data and type(data) == "string" and value) then
        if (interior_data[id] == nil) then
            interior_data[id] = {}
        end

        interior_data[id][tostring(data)] = value
    end
end

function get_interior_data(id, data)
    if (id and type(id) == "number" and data and type(data) == "string") then
        local data_obtained = interior_data[id][data]

        if (data_obtained) then
            return data_obtained
        end

        return false
    end
end