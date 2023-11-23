addEventHandler("onClientResourceStart", resourceRoot, function()
    triggerServerEvent("on_player_request_interior_list", localPlayer, localPlayer)
end)

addEvent("on_player_receive_interior_list", true)
addEventHandler("on_player_receive_interior_list", root, function(interior_list)
    if (interior_list) then
        update_interior_list(interior_list)
    end
end)