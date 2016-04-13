var tile_x = argument0;
var tile_y = argument1;
var tile_type = argument2;
var override = argument3;

var changed = setTile(tile_x, tile_y, tile_type);
if (changed) {
    genTile(tile_x, tile_y, override);
}

return changed;
