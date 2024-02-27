local SALARY_MINUTES = 30

function request_character_group_list(character_id)
    local group_list = exports.database:execute_query("SELECT groups.id, groups.name FROM groups JOIN group_members ON group_members.group_id = groups.id WHERE group_members.member_id = ?", character_id)

    if (group_list) then
        exports.auth:set_character_data(character_id, "group_list", group_list)
    end
end

function update_character_current_group(character_id, group_info)
    if (group_info and type(group_info) == "table") then
        local requested_group_id = group_info["id"]
        local requested_group_name = group_info["name"]

        if (character_id and type(character_id) == "number") then
            local character_group_data = prepare_character_group_data(character_id, requested_group_id)
            
            if (character_group_data) then
                local current_group_id = exports.auth:get_character_data(character_id, "current_group_id")
                
                if (current_group_id) then
                    local current_group_online = get_group_data(current_group_id, "online")
            
                    if (current_group_online) then
                        current_group_online = current_group_online - 1
                        set_group_data(current_group_id, "online", current_group_online)
                    end
                    
                    validate_character_duty_timer_existing(character_id, current_group_id)

                    exports.auth:remove_character_data(character_id, "current_group_id")
                    outputChatBox(string.format("Kończysz pracę w grupie %s. Przepracowałeś łącznie %d minut/y.", requested_group_name, character_group_data["total_duty_time"]))
                else
                    local current_group_online = get_group_data(requested_group_id, "online")
            
                    if (current_group_online) then
                        current_group_online = current_group_online + 1
                        set_group_data(requested_group_id, "online", current_group_online)
                    end
            
                    validate_character_duty_timer_existing(character_id, requested_group_id)
            
                    exports.auth:set_character_data(character_id, "current_group_id", requested_group_id)
                    outputChatBox(string.format("Rozpoczynasz pracę w grupie %s.", requested_group_name))
                end
            end
        end
    end
end

function validate_character_duty_timer_existing(character_id, group_id)
    local character_group_data = prepare_character_group_data(character_id, group_id)

    if (character_group_data and isTimer(character_group_data["duty_timer"])) then
        killTimer(character_group_data["duty_timer"])
    else
        character_group_data["duty_timer"] = setTimer(function()
            update_character_duty_time(character_id)
        end, 1000 * 60, 0)
    end
end

function update_character_duty_time(character_id)
    local player = exports.auth:get_character_data(character_id, "owner")
    local current_group_id = exports.auth:get_character_data(character_id, "current_group_id")

    if (current_group_id) then
        local character_group_data = prepare_character_group_data(character_id, current_group_id)
        character_group_data["total_duty_time"] = character_group_data["total_duty_time"] + 1

        if (character_group_data["total_duty_time"] == PAYMENT_MINUTES) then
            local salary = exports.database:execute_query("SELECT salary FROM group_members WHERE member_id = ? AND group_id = ?", character_id, current_group_id)

            if (salary) then
                salary = salary[1]["salary"]
                outputChatBox(string.format("Otrzymujesz $%d jako wypłatę z grupy.", salary))
            end
        end
    end
end

function save_character_group_data()
    local players = getElementsByType("player")

    for _, player in ipairs(players) do
        local character_id = exports.auth:get_player_data(player, "character_id")

        if (character_id) then
            local group_list = exports.database:execute_query("SELECT group_id FROM group_members WHERE member_id = ?", character_id)

            if (group_list) then
                for _, group in ipairs(group_list) do
                    local group_id = group["group_id"]

                    if (group_id) then
                        local character_group_data = prepare_character_group_data(character_id, group_id)

                        if (character_group_data) then
                            local duty_time = character_group_data["total_duty_time"]
                            exports.database:execute_update("UPDATE group_members SET duty_time = ? WHERE member_id = ? AND group_id = ?", duty_time, character_id, group_id)
                        end
                    end
                end
            end
        end
    end
end