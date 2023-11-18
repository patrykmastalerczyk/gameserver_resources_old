function load_interior(interior_id)
    local interior_data = exports.db_system:db_query("SELECT * FROM `interiors` WHERE `id` = ?", interior_id)

    if (interior_data) then
        local title = interior_data[1]["title"]
        local description = interior_data[1]["description"]
        
        local owner_id = interior_data[1]["owner_id"]
        local owner_type = interior_data[1]["owner_type"]

        local entrance_x, entrance_y, entrance_z = interior_data[1]["entrance_x"], interior_data[1]["entrance_y"], interior_data[1]["entrance_z"]

        local exit_x, exit_y, exit_z = interior_data[1]["exit_x"], interior_data[1]["exit_y"], interior_data[1]["exit_z"]

        local entrance_dimension = interior_data[1]["entrance_dimension"]
        local exit_dimension = interior_data[1]["exit_dimension"]

        set_interior_data(interior_id, "id", interior_id)
        set_interior_data(interior_id, "title", title)
        set_interior_data(interior_id, "description", description)

        set_interior_data(interior_id, "owner_id", owner_id)
        set_interior_data(interior_id, "owner_type", owner_type)

        set_interior_data(interior_id, "entrance_x", entrance_x)
        set_interior_data(interior_id, "entrance_y", entrance_y)
        set_interior_data(interior_id, "entrance_z", entrance_z)

        set_interior_data(interior_id, "exit_x", exit_x)
        set_interior_data(interior_id, "exit_y", exit_y)
        set_interior_data(interior_id, "exit_z", exit_z)

        set_interior_data(interior_id, "entrance_dimension", entrance_dimension)
        set_interior_data(interior_id, "exit_dimension", exit_dimension)

        local entrance_pickup = createPickup(entrance_x, entrance_y, entrance_z, 3, 1318, 0)
        local entrance_col = createColSphere(entrance_x, entrance_y, entrance_z, 1.0)

        setElementData(entrance_col, "interior_id", interior_id)
        setElementData(entrance_col, "type", "entrance")

        setElementDimension(entrance_pickup, entrance_dimension)
        setElementDimension(entrance_col, entrance_dimension)

        local exit_pickup = createPickup(exit_x, exit_y, exit_z, 3, 1318, 0)
        local exit_col = createColSphere(exit_x, exit_y, exit_z, 1.0)

        setElementData(exit_col, "interior_id", interior_id)
        setElementData(exit_col, "type", "exit")

        setElementDimension(exit_pickup, exit_dimension)
        setElementDimension(exit_col, exit_dimension)
    end
end

function create_interior(player)
    local x, y, z = getElementPosition(player)

    local player_dimension = getElementDimension(player)
    local player_interior = getElementInterior(player)

    local _, interior_id = exports.db_system:db_exec("INSERT INTO `interiors` (title, description, entrance_x, entrance_y, entrance_z, exit_x, exit_y, exit_z, entrance_dimension, exit_dimension) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", "testowe przejście", "testowy opis", x, y, z, x, y, z, player_dimension, player_dimension + 1)

    if (interior_id) then
        load_interior(interior_id)
    end
end