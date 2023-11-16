local screen_w, screen_h = guiGetScreenSize()

local login_window = {
    login_button,
    back_button,
    main_window,
    username_edit,
    password_edit,
    username_label,
    password_label
}

local selection_window = {
    main_window,
    login_button,
    register_button,
    login_label,
    register_label
}

local characters_window = {
    main_window,
    choose_button,
    back_button,
    character_list
}

function show_player_selection_window()
    selection_window.main_window = guiCreateWindow((screen_w - 376) / 2, (screen_h - 224) / 2, 376, 224, "Co chcesz zrobić?", false)
    guiWindowSetSizable(selection_window.main_window, false)

    selection_window.login_button = guiCreateButton(15, 165, 121, 33, "Logowanie", false, selection_window.main_window)
    guiSetAlpha(selection_window.login_button, 0.80)
    guiSetFont(selection_window.login_button, "clear-normal")

    selection_window.login_label = guiCreateLabel(15, 40, 142, 65, "Masz już konto?\nZaloguj się do niego, wybierając opcję poniżej!", false, selection_window.main_window)
    guiSetAlpha(selection_window.login_label, 0.80)
    guiSetFont(selection_window.login_label, "clear-normal")
    guiLabelSetHorizontalAlign(selection_window.login_label, "left", true)

    selection_window.register_label = guiCreateLabel(204, 40, 156, 72, "Nie masz konta?\nZarejestruj się wybierając opcję poniżej!", false, selection_window.main_window)
    guiSetAlpha(selection_window.register_label, 0.80)
    guiSetFont(selection_window.register_label, "clear-normal")
    guiLabelSetHorizontalAlign(selection_window.register_label, "right", true)

    selection_window.register_button = guiCreateButton(239, 165, 121, 33, "Rejestracja", false, selection_window.main_window)
    guiSetAlpha(selection_window.register_button, 0.80)
    guiSetFont(selection_window.register_button, "clear-normal")

    addEventHandler("onClientGUIClick", selection_window.login_button, function()
        guiSetVisible(selection_window.main_window, false)

        show_player_login_window()
    end, false)
end

function show_player_login_window()
    login_window.main_window = guiCreateWindow((screen_w - 394) / 2, (screen_h - 260) / 2, 394, 260, "Logowanie", false)
    guiWindowSetMovable(login_window.main_window, false)
    guiWindowSetSizable(login_window.main_window, false)

    login_window.username_edit = guiCreateEdit(78, 54, 238, 27, "", false, login_window.main_window)
    guiSetAlpha(login_window.username_edit, 0.80)

    login_window.login_button = guiCreateButton(78, 224, 114, 26, "Zaloguj", false, login_window.main_window)
    login_window.back_button = guiCreateButton(202, 222, 114, 28, "Wróć", false, login_window.main_window)

    login_window.password_edit = guiCreateEdit(78, 112, 238, 27, "", false, login_window.main_window)
    guiSetAlpha(login_window.password_edit, 0.80)

    login_window.username_label = guiCreateLabel(83, 35, 120, 15, "Nazwa użytkownika", false, login_window.main_window)
    guiSetAlpha(login_window.username_label, 0.80)

    login_window.password_label = guiCreateLabel(83, 97, 120, 15, "Hasło", false, login_window.main_window)
    guiSetAlpha(login_window.password_label, 0.80)

    addEventHandler("onClientGUIClick", login_window.login_button, function()
        local username = guiGetText(login_window.username_edit)
        local password = guiGetText(login_window.password_edit)

        if (username and password) then
            if (type(username) == "string" and type(password) == "string") then
                guiSetVisible(login_window.main_window, false)

                triggerServerEvent("validate_player_credentials", localPlayer, localPlayer, username, password)
            end
        end
    end, false)
end

addEvent("show_player_character_list", true)
addEventHandler("show_player_character_list", root, function(characters)
    local character_list = {}

    for _, character in ipairs(characters) do
        table.insert(character_list, {id = character["id"], first_name = character["first_name"], last_name = character["last_name"]})
    end

    characters_window.main_window = guiCreateWindow((screen_w - 401) / 2, (screen_h - 279) / 2, 401, 279, "Wybór postaci", false)
    guiWindowSetSizable(characters_window.main_window, false)

    characters_window.character_list = guiCreateGridList((401 - 346) / 2, (279 - 170) / 2, 346, 170, false, characters_window.main_window)
    guiGridListSetSelectionMode(characters_window.character_list, 0)

    guiGridListAddColumn(characters_window.character_list, "ID", 0.3)
    guiGridListAddColumn(characters_window.character_list, "Imię", 0.3)
    guiGridListAddColumn(characters_window.character_list, "Nazwisko", 0.3)

    for i = 1, #character_list do
        guiGridListAddRow(characters_window.character_list)
    end

    for k, v in ipairs(character_list) do
        guiGridListSetItemText(characters_window.character_list, k - 1, 1, v["id"], false, false)
        guiGridListSetItemText(characters_window.character_list, k - 1, 2, v["first_name"], false, false)
        guiGridListSetItemText(characters_window.character_list, k - 1, 3, v["last_name"], false, false)
    end

    guiSetAlpha(characters_window.character_list, 0.80)

    characters_window.choose_button = guiCreateButton(36, 238, 120, 31, "Wybierz", false, characters_window.main_window)
    characters_window.back_button = guiCreateButton(246, 238, 120, 31, "Wróć", false, characters_window.main_window)

    addEventHandler("onClientGUIClick", characters_window.choose_button, function()
        local selected_item = guiGridListGetSelectedItem(characters_window.character_list)
        
        if selected_item then
            triggerServerEvent("validate_player_character", localPlayer, localPlayer, character_list[selected_item + 1]["id"])

            guiSetVisible(characters_window.main_window, false)
            showCursor(false)
            toggle_player_default_components(true)
        end
    end, false)
end)