prepared_character_list = {}

function validate_player_credentials(player, username, password)
    if (player and username and password) then
        local player_data = exports.database:execute_query("SELECT * FROM `players` WHERE `username` = ?", username)

        if (player_data) then
            local hashed_password = player_data[1]["password"]

            if (hashed_password) then
                local password_match = passwordVerify(password, hashed_password)

                if (password_match) then
                    set_player_data(player, "id", player_data[1]["id"])
                    set_player_data(player, "username", player_data[1]["username"])
                    set_player_data(player, "logged_in", true)
                    show_player_character_list(player)
                else
                    outputChatBox("Wprowadzone hasło jest nieprawidłowe.")
                end
            end
        else
            outputChatBox("Użytkownik o tej nazwie nie istnieje.")
        end
    end
end

function show_player_character_list(player)
    if (player) then
        local player_id = get_player_data(player, "id")

        if (player_id) then
            if not prepared_character_list[player_id] then
                prepared_character_list[player_id] = {}
            end

            local character_list = exports.database:execute_query("SELECT * FROM `characters` WHERE `owner_id` = ?", player_id)

            if (character_list) then
                for _, character in ipairs(character_list) do
                    local character_data = {
                        id = character["id"],
                        first_name = character["first_name"],
                        last_name = character["last_name"],
                        health = character["health"],
                        armor = character["armor"],
                        skin = character["skin"],
                        sex = character["sex"],
                        cash = character["cash"],
                        account_balance = character["account_balance"],
                        identity_card = character["identity_card"],
                        drivers_license = character["drivers_license"]
                    }
                    table.insert(prepared_character_list[player_id], character_data)
                end

                outputChatBox("Wybierz postać, którą chcesz grać:")
                for slot, character in ipairs(prepared_character_list[player_id]) do
                    outputChatBox(string.format("%s %s (s: %d)", character["first_name"], character["last_name"], slot))
                end
            end
        end
    end
end

function validate_player_character(player, selected_character_id)
    local player_id = get_player_data(player, "id")

    if (player_id) then
        local character_list = prepared_character_list[player_id]

        if (character_list) then
            local selected_character = character_list[selected_character_id]
            
            if (selected_character) then
                initialize_player_character(player, selected_character)

                outputChatBox(string.format("Zalogowałeś się na postać: %s %s.", selected_character["first_name"], selected_character["last_name"]))
                prepared_character_list[player_id] = nil
            end
        end
    end
end

function initialize_player_character(player, character)
    local character_id = character["id"]

    if (character_id) then
        local player_id = get_player_data(player, "id")

        if (player_id) then
            local first_name = character["first_name"]
            local last_name = character["last_name"]
            local health = character["health"]
            local armor = character["armor"]
            local skin = character["skin"]
            local sex = character["sex"]
            local cash = character["cash"]
            local account_balance = character["account_balance"]
            local identity_card = character["identity_card"]
            local drivers_license = character["drivers_license"]

                        
            set_player_data(player, "character_id", character_id)
            
            set_character_data(character_id, "owner", player)
            set_character_data(character_id, "owner_id", player_id)

            set_character_data(character_id, "first_name", first_name)
            set_character_data(character_id, "last_name", last_name)
            set_character_data(character_id, "health", health)
            set_character_data(character_id, "armor", armor)
            set_character_data(character_id, "skin", skin)
            set_character_data(character_id, "sex", sex)
            set_character_data(character_id, "cash", cash)
            set_character_data(character_id, "account_balance", account_balance)
            set_character_data(character_id, "identity_card", identity_card)
            set_character_data(character_id, "drivers_license", drivers_license)

            exports.groups:request_character_group_list(character_id)
            exports.items:request_character_item_list(character_id)

            fadeCamera(player, true)
            setCameraTarget(player, player)
            spawnPlayer(player, 1743.542969, -1862.963867, 13.575652)

            setElementModel(player, skin)
            setPlayerMoney(player, cash)
            setElementHealth(player, health)
            setPedArmor(player, armor)
        end
    end
end