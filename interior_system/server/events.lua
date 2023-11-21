addEventHandler("onResourceStart", root, function()
    load_interiors()
end)

addEvent("on_player_request_interior_list", true)
addEventHandler("on_player_request_interior_list", root, function(player)
    local interior_list = get_interiors_data()
    
    if (interior_list) then
        triggerClientEvent(player, "on_player_receive_interior_list", player, interior_list)
    end
end)