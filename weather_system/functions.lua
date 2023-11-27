local current_weather = nil

local weather_list = {1, 4, 8}

function change_weather(weather_id)
    if (weather_id == nil) then
        local random_index = math.random(1, #weather_list)
        local random_weather = weather_list[random_index]

        if not (random_weather == current_weather) then
            local weather_change_interval = math.random(60, 120)

            setWeather(random_weather)
            current_weather = random_weather

            local weather_change_timer = setTimer(function()
                change_weather()
            end, 1000 * 60 * weather_change_interval, 0)
        end
    else
        setWeather(weather_id)
        current_weather = weather_list[weather_id]
    end
end

function get_current_weather()
    return current_weather
end