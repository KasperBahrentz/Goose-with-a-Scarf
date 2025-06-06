// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

/// @function                   screenshake(_time, _magnitude, _fade);
/// @param  {real}  _time       The length of time - in steps - to shake the screen
/// @param  {real}  _magnitude  The amount of screenshake to apply
/// @param  {real}  _fade       How quickly the screenshake effect will fade out
/// @description    Set the screenshake object variables.

function get_tileset_name(){
	var tilemap_id = layer_tilemap_get_id("ground");
	var tileset_id = tilemap_get_tileset(tilemap_id);
	return tileset_get_name(tileset_id); 
}


// Make things fly above the player and follow them
function follow_player(_lerp_amount, _y_distance_to_player){
	x = lerp(x, objGooseBody.x, _lerp_amount);
	y = lerp(y, objGooseBody.y-_y_distance_to_player*pixel_size, _lerp_amount);
		
	if (objGooseBody.state == player_state.DIE){
		instance_destroy();	
	}	
}

function is_on_tilemap(_tilemap_id, _y){
	// Convert object position to tile coordinates
	var tile_x = tilemap_get_cell_x_at_pixel(_tilemap_id, x, _y);
	var tile_y = tilemap_get_cell_y_at_pixel(_tilemap_id, x, _y);

	// Get tile data
	var tile_data = tilemap_get(_tilemap_id, tile_x, tile_y);

	// Check if there's a tile (non-zero = tile exists)
	if (tile_data != 0) {
		return true;
	}
	return false;
}

function set_direction(_direction){
	switch(_direction){	
		case "up":		direction = random_range(35, 145);	break;
		case "left":	direction = random_range(145, 225);	break;
		case "down":	direction = random_range(225, 315);	break;
		case "right":	direction = random_range(315, 360+35);	break;
	}
}

function screenshake(_time, _magnitude, _fade){
   with (objCam) {
      shake = true;
      shake_time = _time;
      shake_magnitude = _magnitude;
      shake_fade = _fade;
   }
}

function draw_sprite_custom(_sprite, _image_index){
	draw_sprite_ext(_sprite, _image_index, x, y, image_xscale, image_yscale, 0, objGooseBody.image_blend, 1);
}

function cover_all_water_tiles(_tilemap_layer_name) {
    var tilemap_id = layer_tilemap_get_id(_tilemap_layer_name);
    var tilemap_width = tilemap_get_width(tilemap_id);     // In tiles
    var tilemap_height = tilemap_get_height(tilemap_id);   // In tiles

    for (var ty = 0; ty < tilemap_height; ty++) {
        for (var tx = 0; tx < tilemap_width; tx++) {
            var tile = tilemap_get(tilemap_id, tx, ty);
            if (tile > 0) {
                var pixel_x = tx * tile_size;
                var pixel_y = ty * tile_size;
                instance_create_layer(pixel_x, pixel_y, "collision", objWaterDetection);
            }
        }
    }
}

function layer_has_tiles(layer_name){
	var tilemap_id = layer_tilemap_get_id(layer_get_id(layer_name));

	var found_tile = false;
	var tile_width = tilemap_get_tile_width(tilemap_id);
	var tile_height = tilemap_get_tile_height(tilemap_id);
	var width = tilemap_get_width(tilemap_id);
	var height = tilemap_get_height(tilemap_id);

	// Loop through all tiles in the tilemap
	for (var ty = 0; ty < height; ty++) {
	    for (var tx = 0; tx < width; tx++) {
	        var tile_index = tilemap_get(tilemap_id, tx, ty);
	        if (tile_index != 0) {
	            found_tile = true;
	            break; // Found a tile, exit inner loop
	        }
	    }
	    if (found_tile) break; // Exit outer loop as well
	}

	if (found_tile) {
	   return true;
	} else {
	    return false;
	}
}