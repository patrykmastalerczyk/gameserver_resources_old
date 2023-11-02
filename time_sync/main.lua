addEventHandler("onResourceStart", getResourceRootElement(), function()
    update_time()
end)

function update_time()
    local current_time = getRealTime()

    setTime(current_time.hour, current_time.minute)
    setMinuteDuration(1000 * 60)

    setTimer(function()
        current_time = getRealTime()

        if (current_time.minute == 0 and current_time.second == 0) then
            setTime(current_time.hour, current_time.minute)

            outputDebugString(string.format("Aktualna godzina: %02d:%02d:%02d", current_time.hour, current_time.minute, current_time.second))
        end
    end, 1000, 0)
end

