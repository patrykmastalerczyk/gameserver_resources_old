function is_player_within_interior_marker(player)
    local player_position = getElementPosition(player)
    local player_dimension = getElementDimension(player)

    for _, marker in ipairs(getElementsByType("marker")) do
        local marker_dimension = getElementDimension(marker)

        if (player_dimension == marker_dimension) then
            local interior_id = getElementData(marker, "interior_id")

            if (interior_id) then -- check if marker is assigned to any interior
                if (isElementWithinMarker(player, marker)) then
                    return marker
                end
            end
        end
    end
end