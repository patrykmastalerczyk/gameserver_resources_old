addEventHandler("onClientResourceStart", resourceRoot, function()
    fadeCamera(true)
    outputChatBox("\nZaloguj się na swoje konto:\n/account login [login] [hasło]\n", 255, 255, 255, true)
end)