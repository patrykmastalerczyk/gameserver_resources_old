local character_data = {}

function set_character_data(id, data, value)
    if (id and type(id) == "number" and data and type(data) == "string" and value) then
        if (character_data[id] == nil) then
            character_data[id] = {}
        end

        character_data[id][tostring(data)] = value
    end

    return false
end

function get_character_data(id, data)
    if (id and type(id) == "number" and data and type(data) == "string") then
        local data_obtained = character_data[id][data]

        if (data_obtained) then
            return data_obtained
        end
    end
end

function remove_character_data(id, data)
    if (id and type(id) == "number" and data and type(data) == "string") then
        if not (character_data[id][data] == nil) then
            character_data[id][tostring(data)] = nil
        end
    end
end