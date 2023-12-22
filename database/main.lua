local db_settings = {
    host = "localhost",
    username = "root",
    password = "",
    db_name = "mta_db",

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

function execute_query(...)
    if (db_settings.db_connection) then
        local query_handle = dbQuery(db_settings.db_connection, ...)

        if (query_handle) then
            local result, num_affected_rows, last_insert_id = dbPoll(query_handle, -1)

            -- if (#result == 1) then result = result[1] end
            if (#result == 0) then result = nil end

            return result, num_affected_rows, last_insert_id
        end
    end
end

function execute_update(...)
    if (db_settings.db_connection) then
        local query_handle = dbQuery(db_settings.db_connection, ...)

        if (query_handle) then
            local result, num_affected_rows, last_insert_id = dbPoll(query_handle, -1)

            if (num_affected_rows > 0) then
                return num_affected_rows, last_insert_id
            end
        end
    end
end

