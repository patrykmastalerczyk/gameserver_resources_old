addCommandHandler("int", function(player, command, ...)
    local args = {...}

    if (args[1] == "dim") then
        setElementDimension(player, args[2])
        outputChatBox(string.format("Zmiana wymiaru na: %d", args[2]))
        outputChatBox(string.format("Zmieniono wymiar na: %d", getElementDimension(player)))
    end
end)