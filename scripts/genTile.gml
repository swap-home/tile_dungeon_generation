var tile_x = argument0;
var tile_y = argument1;

var override = argument2; // Spawn this instead (like a chest)

//uses mobs - ds_list of available mobs to spawn
//uses mob_density - % chance to spawn a mob
//sets tile_obj

if (!instance_exists(global.map_ctrl)) {
    show_error("Map controller required when trying to genTile", true);
}

with(global.map_ctrl) {
    if (object_exists(override)) {
        var ID = instance_create(tile_x, tile_y, override);
        tile_obj[# tile_x, tile_y] = ID;
        ID.x = tile_x * TILE_SIZE;
        ID.y = tile_y * TILE_SIZE;
        
    } else if (random(1) < mob_density) {
        var mob_count = ds_list_size(mobs);
        var mob_chosen = irandom(mob_count-1);
        var ID = instance_create(tile_x, tile_y, mobs[| mob_chosen]);
        tile_obj[# tile_x, tile_y] = ID;
        ID.x = tile_x * TILE_SIZE;
        ID.y = tile_y * TILE_SIZE;
    }
}


