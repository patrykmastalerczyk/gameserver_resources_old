local db_connection = get_database_connection()

function fetch_data(...)
    if (db_connection) then
        local query_handle = dbQuery(db_connection, ...)

        if (not query_handle) then
            outputDebugString("Błąd podczas wykonywania zapytania.")
            return nil
        end

        local result, num_rows, last_insert_id = dbPoll(query_handle, -1)

        if (result and #result > 0) then
            return result, num_rows, last_insert_id
        else
            outputDebugString("Brak danych pasujących do zapytania.")
            return nil
        end
    end
end

function execute_query(...)
    if (db_connection) then
        local query_handle = dbQuery(db_connection, ...)

        local result, num_rows, last_insert_id = dbPoll(query_handle, -1)
        return num_rows, last_insert_id
    end
end