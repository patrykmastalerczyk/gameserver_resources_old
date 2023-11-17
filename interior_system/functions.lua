function load_interior(interior_id)
    local interior_data = exports.db_system:db_query("SELECT * FROM `interiors` WHERE `id` = ?", interior_id)

    if (interior_data) then
        local x, y, z = interior_data[1]["x"], interior_data[1]["y"], interior_data[1]["z"]

        local pickup_dimension = interior_data[1]["dimension"]
        local pickup_interior = interior_data[1]["interior"]
        local pickup_title = interior_data[1]["title"]

        local interior_pickup = createPickup(x, y, z, 3, 1318, 0)

        setElementDimension(interior_pickup, pickup_dimension)
        setElementInterior(interior_pickup, pickup_interior)
    end
end

function create_interior(player)
    local x, y, z = getElementPosition(player)

    local player_dimension = getElementDimension(player)
    local player_interior = getElementInterior(player)

    local _, interior_id = exports.db_system:db_exec("INSERT INTO `interiors` (title, x, y, z, dimension, interior) VALUES (?, ?, ?, ?, ?, ?)", "test", x, y, z, player_dimension, player_interior)

    load_interior(interior_id)
end