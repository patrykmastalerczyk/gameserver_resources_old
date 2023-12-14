function show_player_auth_selection()
    -- toggle_player_default_components(false)
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

addEvent("invalid_data", true)
addEventHandler("invalid_data", root, function(data_type)
    if (data_type == "password") then
        outputChatBox("Niepoprawne hasło.")
    elseif (data_type == "username") then
        outputChatBox("Niepoprawna nazwa użytkownika.")
    end
end) -- todo


addEvent("destroy_login_window", true)
addEventHandler("destroy_login_window", root, function(data_type)
    guiSetVisible(login_window.main_window, false)
end) -- todo

function get_character_id(player)
    if (player and getElementType(player) == "player") then
        local character_id = getElementData(player, "character_id")
        
        if (character_id) then
            return character_id
        end
    end
end