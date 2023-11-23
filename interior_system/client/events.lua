local light = dxCreateTexture("light.png", "argb")
local arrow = dxCreateTexture("arrow.png", "argb")

local anim_type = "foward"
local max_distance = 90
local max_text_distance = 45
local animTime = 0

addEventHandler("onClientRender", root, function()
    local player_dimension = getElementDimension(localPlayer)

    for _, marker in ipairs(getElementsByType("marker")) do
        local marker_dimension = getElementDimension(marker)

        if (marker_dimension == player_dimension) then
            local px, py, pz = getElementPosition(localPlayer)
            local mx, my, mz = getElementPosition(marker)

            local r, g, b = getMarkerColor(marker)

            local distance_between = getDistanceBetweenPoints3D(px, py, pz, mx, my, mz)
            local icon_alpha = interpolateBetween(0, 0, 0, 255, 0, 0, 1 - math.min(distance_between / max_distance, 1), "Linear")
            local sx, sy = getScreenFromWorldPosition(mx, my, mz + 0.5)
            local text_size = interpolateBetween(0, 0, 0, 1.5, 0, 0, 1 - math.min(distance_between / max_text_distance, 1), "Linear")
            local text_alpha = interpolateBetween(0, 0, 0, 255, 0, 0, 1 - math.min(distance_between / max_text_distance, 1), "Linear")

            if (distance_between <= max_distance) then
                local marker_size = getMarkerSize(marker)

                dxDrawMaterialLine3D(mx, my, mz + 2, mx, my, mz + 1, arrow, 1.0, tocolor(r, g, b, icon_alpha))
                dxDrawMaterialLine3D(mx + marker_size, my + marker_size, mz + 0.04, mx - marker_size, my - marker_size, mz + 0.04, light, marker_size * 3, tocolor(r, g, b, icon_alpha), mx, my, mz)

                if (sx and sy) then
                    dxDrawText("Nazwa interioru.\nNaciśnij E, aby wejść.", sx, sy, sx, sy, tocolor(255, 255, 255, text_alpha), text_size, "arial", "center", "bottom", false, false, false, true)
                end
            end
        end
    end
end)