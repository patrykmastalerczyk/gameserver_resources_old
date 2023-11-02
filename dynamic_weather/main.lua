local current_weather = nil

local weather_list = {
    14,
    15,
    16
}

addEventHandler("onResourceStart", getResourceRootElement(), function()
    change_weather()
end)

function change_weather(weather_id)
    if (weather_id == nil) then
        local random_weather = math.random(1, #weather_list)

        if (current_weather ~= random_weather) then
            setWeather(weather_list[random_weather])

            current_weather = weather_list[random_weather]
        end
    else
        setWeather(weather_id)
        
        current_weather = weather_list[weather_id]
    end
end