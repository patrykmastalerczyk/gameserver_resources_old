function request_character_item_list(character_id)
    local item_list = exports.database:execute_query("SELECT * FROM items WHERE owner_type = 1 AND owner_id = ?", character_id)

    if (item_list) then
        exports.auth:set_character_data(character_id, "item_list", item_list)
    end
end

function update_character_item_list(character_id, item_list)
    local updated_item_list = {}
    local updated_item_slot = 1

    for item_slot, item in ipairs(item_list) do
        local item_used = item["used"]
        local item_active = item["active"]

        if (item_used == 0) then -- Jeśli przedmiot jest zużyty, nie dodajemy go do nowej tablicy.
            updated_item_list[updated_item_slot] = item_list[item_slot]

            updated_item_slot = updated_item_slot + 1
        end
    end

    exports.auth:set_character_data(character_id, "item_list", updated_item_list)
end