function show_player_auth_selection()
    toggle_player_default_components(false)
    showCursor(true)

    if (isCursorShowing()) then
        show_player_selection_window()
    end
end

function toggle_player_default_components(state)
    if (type(state) == "boolean") then
        showChat(state)
        setPlayerHudComponentVisible("all", state)
    end
end

addEvent("show_player_spawn_selection", true)
addEventHandler("show_player_spawn_selection", root, function()
end) -- todo