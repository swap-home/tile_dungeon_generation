var tile_x = argument0;     // x coord
var tile_y = argument1;     // y coord
var tile_type = argument2;  // type of tile

var changed = false;        //return true if setTile successful, false if coords out of bounds or tile did not change

// uses w, h, tile_types, tile_ids
if (!instance_exists(global.map_ctrl)) {
    show_error("Map controller required when trying to setTile", true);
}

with(global.map_ctrl) {
    if (tile_x < 0 || tile_x >= w || tile_y < 0 || tile_y >= h) {return changed;}
    if (tile_types[# tile_x, tile_y] == tile_type) {return changed;}
    
    tile_types[# tile_x, tile_y] = tile_type;
    tile_set_region(tile_ids[# tile_x, tile_y], TILE_SIZE * tile_type, 0, TILE_SIZE, TILE_SIZE);
    changed = true;
}

return changed;
