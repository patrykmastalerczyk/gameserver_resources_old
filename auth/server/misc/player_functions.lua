local player_data = {}

function set_player_data(player, data, value)
    if (player and getElementType(player) == "player" and data and type(data) == "string" and value) then
        if (player_data[player] == nil) then
            player_data[player] = {}
        end

        player_data[player][tostring(data)] = value
    end

    return false
end

function get_player_data(player, data)
    if (player and getElementType(player) == "player" and data and type(data) == "string") then
        local data_obtained = player_data[player][data]

        if (data_obtained) then
            return data_obtained
        end
    end

    return false
end

function send_player_message(player, message)
    outputChatBox(message, player)
end