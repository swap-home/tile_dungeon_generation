// fill up to number of tiles
if (tiles_changed < max_tiles_changed) {
    setTile(tile_x, tile_y, 1);

    var up, down, left, right;
    up = up_base_weight;
    down = down_base_weight;
    left = left_base_weight;
    right = right_base_weight;
    
    if (tile_x < w/2) {
        right += center_weight;
    } else {
        left += center_weight;
    }
    if (tile_y < h/2) {
        down += center_weight;
    } else {
        up += center_weight;
    }
    
    switch(last_choice) {
        case 0: 
            up += forward_weight; 
            left += turn_weight;
            right += turn_weight;
            down += reverse_weight;
            break;
        case 1: 
            up += reverse_weight; 
            left += turn_weight;
            right += turn_weight;
            down += forward_weight;
            break;
        case 2: 
            up += turn_weight; 
            left += forward_weight;
            right += reverse_weight;
            down += turn_weight;
            break;
        case 3: 
            up += turn_weight; 
            left += reverse_weight;
            right += forward_weight;
            down += turn_weight;
            break;
    }
    var choice;
    if (last_choice == -1) {
        choice = roll(1,1,1,1);
    } else {
        choice = roll(up,down,left,right);
    }
    var reverse = false;
    
    //TODO: DRY regeneration duplication
    switch(choice) {
        case 2: 
            if (--tile_x < 0) {
                tile_x = 0; 
                if (border_count++ > border_max_or_restart) {
                    instance_destroy();
                    with (global.gui_ctrl) {instance_destroy();}
                    room_restart();
                    exit;
                };
            } 
            if (last_choice == 3) {reverse = true;}
            break;

        case 3: 
            if (++tile_x >= w) {
                tile_x = w-1;
                if (border_count++ > border_max_or_restart) {
                    instance_destroy();
                    with (global.gui_ctrl) {instance_destroy();}                    
                    room_restart();
                    exit;
                };
            } 
            if (last_choice == 2) {reverse = true;}
            break;

        case 0: 
            if (--tile_y < 0) {
                tile_y = 0;
                if (border_count++ > border_max_or_restart) {
                    instance_destroy();
                    with (global.gui_ctrl) {instance_destroy();}                    
                    room_restart();
                    exit;
                };
            } 
            if (last_choice == 1) {reverse = true;}
            break;

        case 1: if (++tile_y >= h) {
                tile_y = h-1;
                if (border_count++ > border_max_or_restart) {
                    instance_destroy();
                    with (global.gui_ctrl) {instance_destroy();}                    
                    room_restart();
                    exit;
                };
            } 
            if (last_choice == 0) {reverse = true;}
            break;
    }

    /*
    
    case 2 draws: 3x3
    X X X
    X - -
    X - -
    
    case 1 draws: 2z2
    - - -
    - - X
    - X X
    
    case 0 draws: 1x1
    - - -
    - X - 
    - - -
    
    */    
    var override = -1;
    if (reverse) {override = o_crate;}
    var brush_size = roll(single_block, double_block, triple_block);
    switch (brush_size) {
        case 2:
            if (setAndGenTile(tile_x-1, tile_y-1, 1, override)) {tiles_changed++;}
            if (setAndGenTile(tile_x, tile_y-1, 1, override)) {tiles_changed++;}
            if (setAndGenTile(tile_x+1, tile_y-1, 1, override)) {tiles_changed++;}
            if (setAndGenTile(tile_x-1, tile_y, 1, override)) {tiles_changed++;}
            if (setAndGenTile(tile_x-1, tile_y+1, 1, override)) {tiles_changed++;}

        case 1:
            if (setAndGenTile(tile_x+1, tile_y, 1, override)) {tiles_changed++;}
            if (setAndGenTile(tile_x, tile_y+1, 1, override)) {tiles_changed++;}
            if (setAndGenTile(tile_x+1, tile_y+1, 1, override)) {tiles_changed++;}
        
        case 0:
            if (setAndGenTile(tile_x, tile_y, 1, override)) {tiles_changed++;}
            last_choice = choice;
    }
    
} else {
    // set starting tile to stairs
    setTile(floor(w/2), floor(h/2), 3);
    // set last tile to stairs
    setTile(tile_x, tile_y, 4);
    generated = true;
}
