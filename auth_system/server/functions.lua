local character_data = {}

function set_character_data(id, data, value)
    if (id and type(id) == "number" and data and type(data) == "string" and value) then
        if (character_data[id] == nil) then
            character_data[id] = {}
        end

        character_data[id][tostring(data)] = value
    end
end

function get_character_data(id, data)
    if (id and type(id) == "number" and data and type(data) == "string") then
        local data_obtained = character_data[id][data]

        if (data_obtained) then
            return data_obtained
        end
    end
end

function spawn_player_character(player, character_id)
    if (player and character_id) then
        local character_skin = get_character_data(character_id, "skin")

        spawnPlayer(player, 1480.273438, -1723.510742, 13.546875)
        setElementModel(player, character_skin)
        setCameraTarget(player, player)
        fadeCamera(player, true)
    end
end

function fetch_player_character_list(player, player_id)
    if (player and player_id) then
        local character_list = exports.db_system:db_query("SELECT `id`, `first_name`, `last_name` FROM `characters` WHERE `owner_id` = ?", player_id)

        if (character_list) then
            outputDebugString("fetch_player_character_list triggered")
            triggerClientEvent(player, "show_player_character_list", player, character_list)
        end
    end
end

function assign_player_data(player, player_data)
    if (player and player_data) then
        setElementData(player, "id", player_data[1]["id"])
        setElementData(player, "name", player_data[1]["username"])

        fetch_player_character_list(player, player_data[1]["id"])
    end
end

function assign_player_character_data(player, character_id, character_data)
    if (player and character_id and character_data) then
        local player_id = getElementData(player, "id")
        local player_name = getElementData(player, "name")

        if (player_id and player_name) then
            set_character_data(character_id, "id", character_data[1]["id"])
            set_character_data(character_id, "first_name", character_data[1]["first_name"])
            set_character_data(character_id, "last_name", character_data[1]["last_name"])
            set_character_data(character_id, "skin", character_data[1]["skin"])

            set_character_data(character_id, "owner_id", player_id)
            set_character_data(character_id, "owner_username", player_name)

            spawn_player_character(player, character_id)
        end
    end
end