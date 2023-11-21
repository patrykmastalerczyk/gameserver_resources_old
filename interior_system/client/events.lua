addEventHandler("onClientResourceStart", resourceRoot, function()
    triggerServerEvent("on_player_request_interior_list", localPlayer, localPlayer)
end)

addEvent("on_player_receive_interior_list", true)
addEventHandler("on_player_receive_interior_list", root, function(interior_list)
    if (interior_list and type(interior_list) == "table") then
        set_interiors_position(interior_list)
    end
end)