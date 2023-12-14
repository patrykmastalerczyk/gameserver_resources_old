function initialize_character_group_list()
    triggerServerEvent("on_player_request_character_group_list", localPlayer, localPlayer)
end

function toggle_character_service_status(group_id)
    local character_id = exports.auth_system:get_character_id(localPlayer)
    triggerServerEvent("on_player_request_duty_state_change", localPlayer, character_id, group_id)
    -- outputChatBox(tostring(group_id))
end