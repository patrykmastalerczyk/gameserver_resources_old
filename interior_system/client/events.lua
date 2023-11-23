local light = dxCreateTexture("light.png", "argb")
local arrow = dxCreateTexture("arrow.png", "argb")

local ICON_MAX_ALPHA = 155
local ICON_MAX_DISTANCE = 45

local TEXT_MAX_ALPHA = 155
local TEXT_MAX_SIZE = 1.5
local TEXT_MAX_DISTANCE = 45

addEventHandler("onClientRender", root, function()
    local player_dimension = getElementDimension(localPlayer)
    local px, py, pz = getElementPosition(localPlayer)

    for _, marker in ipairs(getElementsByType("marker")) do
        local interior_id = getElementData(marker, "interior_id")
        local marker_dimension = getElementDimension(marker)

        if (marker_dimension == player_dimension) then
            local marker_size = getMarkerSize(marker)

            local mx, my, mz = getElementPosition(marker)
            local r, g, b = getMarkerColor(marker)

            local distance_between = getDistanceBetweenPoints3D(px, py, pz, mx, my, mz)
            local icon_alpha = interpolateBetween(0, 0, 0, ICON_MAX_ALPHA, 0, 0, 1 - math.min(distance_between / ICON_MAX_DISTANCE, 1), "Linear")

            local text_size = interpolateBetween(0, 0, 0, TEXT_MAX_SIZE, 0, 0, 1 - math.min(distance_between / TEXT_MAX_DISTANCE, 1), "Linear")
            local text_alpha = interpolateBetween(0, 0, 0, TEXT_MAX_ALPHA, 0, 0, 1 - math.min(distance_between / TEXT_MAX_DISTANCE, 1), "Linear")

            if (distance_between <= ICON_MAX_DISTANCE) then
                dxDrawMaterialLine3D(mx, my, mz + 2, mx, my, mz + 1, arrow, 1.0, tocolor(r, g, b, icon_alpha))
                dxDrawMaterialLine3D(mx + marker_size, my + marker_size, mz + 0.04, mx - marker_size, my - marker_size, mz + 0.04, light, marker_size * 3, tocolor(r, g, b, icon_alpha), mx, my, mz)

                local sx1, sy1 = getScreenFromWorldPosition(mx, my, mz + 0.7)
                local sx2, sy2 = getScreenFromWorldPosition(mx, my, mz + 0.5)

                if (sx1 and sy1 and sy2 and sx2) then
                    local interior_title = get_interior_data(interior_id, "title")

                    if (interior_title) then
                        dxDrawText(interior_title, sx1, sy1, sx1, sy1, tocolor(255, 255, 255, text_alpha), text_size, "default-bold", "center", "bottom", false, false, false, true)
                        dxDrawText("Naciśnij E, aby wejść.", sx2, sy2, sx2, sy2, tocolor(255, 255, 255, text_alpha), text_size, "default", "center", "bottom", false, false, false, true)
                    end
                end
            end
        end
    end
end)

addEventHandler("onClientKey", root, function(pressed_button, button_press)
    if (pressed_button == "e" and button_press) then
        local interior_marker = is_player_within_interior_marker(localPlayer)

        if (interior_marker) then
            triggerServerEvent("on_player_request_interior_change", localPlayer, localPlayer, interior_marker)
        end
    end
end)