addCommandHandler("int", function(player, command, ...)
    local args = {...}

    if (args[1] == "c") then
        create_interior(player)
    end

    if (args[1] == "dim") then
        setElementDimension(player, args[2])
        outputChatBox(tostring(getElementDimension(player)))
    end
end)