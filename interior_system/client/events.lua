addEventHandler("onClientKey", root, function(pressed_button, button_state_down)
    if (pressed_button == "e" and button_state_down) then
        local colshape = is_player_within_colshape(localPlayer)

        if (colshape) then
            local action_type = getElementData(colshape, "type")
            local interior_id = getElementData(colshape, "interior_id")

            outputChatBox(action_type)

            if (action_type == "entrance") then
                triggerServerEvent("on_player_interior_change", localPlayer, localPlayer, interior_id, action_type)
            end
            
            if (action_type == "exit") then
                triggerServerEvent("on_player_interior_change", localPlayer, localPlayer, interior_id, action_type)
            end
        end
    end
end)

function is_player_within_colshape(player)
    if (player and getElementType(player) == "player") then
        local colshape_dimension = nil
        local player_dimension = getElementDimension(player)

        for _, colshape in ipairs(getElementsByType("colshape")) do
            colshape_dimension = getElementDimension(colshape)

            if (colshape_dimension == player_dimension) then
                return colshape
            end
        end

        return false
    end
end
            