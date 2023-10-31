local db_settings = {
    host = "localhost",
    username = "root",
    password = "",
    db_name = "gameserver_db",
    db_connection = nil
}

addEventHandler("onResourceStart", getResourceRootElement(), function()
    db_settings.db_connection = dbConnect("mysql", string.format("dbname=%s;host=%s", db_settings.db_name, db_settings.host), db_settings.username, db_settings.password)

    if (db_settings.db_connection) then
        outputDebugString("Połączenie z bazą danych zostało nawiązane.")
    else
        outputDebugString("Nie udało się nawiązać połączenia z bazą danych.")
    end
end)

addEventHandler("onResourceStop", getResourceRootElement(), function()
    if (isElement(db_settings.db_connection)) then
        destroyElement(db_settings.db_connection)

        outputDebugString("Zakończono połączenie z bazą danych.")
    end
end)

function get_database_connection()
    return db_settings.db_connection
end