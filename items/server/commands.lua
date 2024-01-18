addCommandHandler("item", function(player, command_name, ...)
    local character_id = exports.auth:get_player_data(player, "character_id")

    if (character_id) then
        local item_list = exports.auth:get_character_data(character_id, "item_list")

        if (item_list) then
            local args = {...}
            if (#item_list == 0) then return outputChatBox("Nie posiadasz przy sobie żadnych przedmiotów.") end

            if not (args[1]) then
                for slot, item in ipairs(item_list) do
                    if (item["used"] == 0) then
                        outputChatBox(string.format("%d %s", slot, item["name"]))
                    end
                end
            end

            if (args[1]) then
                local item_slot = tonumber(args[1])

                if (item_list[item_slot]) then
                    local item_action = tostring(args[2])

                    if (item_action == "use") then
                        local item_type = item_list[item_slot]["type"]

                        triggerEvent("on_character_item_use", player, character_id)
                    end
                end
            end
        end
    end
end)