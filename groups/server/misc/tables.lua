local group_data = {} -- online, vehicles
local character_group_data = {} -- duty_timer, total_duty_time, total_offers

function set_group_data(id, data, value)
    if (id and type(id) == "number" and data and type(data) == "string" and value) then
        if (group_data[id] == nil) then
            group_data[id] = {}
        end

        group_data[id][tostring(data)] = value
    end

    return false
end

function get_group_data(id, data)
    if (id and type(id) == "number" and data and type(data) == "string") then
        local data_obtained = group_data[id][data]

        if (data_obtained) then
            return data_obtained
        end
    end

    return false
end

function prepare_character_group_data(character_id, group_id)
    if not character_group_data[character_id] then
        character_group_data[character_id] = {}
    end

    if not character_group_data[character_id][group_id] then
        character_group_data[character_id][group_id] = {}
        character_group_data[character_id][group_id]["duty_timer"] = {}
        character_group_data[character_id][group_id]["total_duty_time"] = 0
        character_group_data[character_id][group_id]["total_offers"] = 0
    end

    return character_group_data[character_id][group_id]
end


function set_character_group_data(character_id, group_id, data, value)
end
