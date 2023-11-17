addCommandHandler("int", function(player, command, ...)
    local args = {...}

    if (args[1] == "c") then
        create_interior(player)
    end
end)