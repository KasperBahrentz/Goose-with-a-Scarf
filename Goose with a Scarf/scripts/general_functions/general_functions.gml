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

function draw_sprite_custom(sprite){
	draw_sprite_ext(sprite, image_index, x, y, image_xscale, image_yscale, 0, objGooseBody.image_blend, 1);
}

function calc_dist_to_water(_tilemap){
	var tilemap_id = layer_tilemap_get_id(_tilemap);

	var origin_tile_x = tilemap_get_cell_x_at_pixel(tilemap_id, x, y);
	var origin_tile_y = tilemap_get_cell_y_at_pixel(tilemap_id, x, y);

	var search_radius = 7;
	var nearest_dist = 1000000;
	var nearest_tile_x = -1;
	var nearest_tile_y = -1;

	for (var yy = -search_radius; yy <= search_radius; yy++) {
	    for (var xx = -search_radius; xx <= search_radius; xx++) {
	        var tx = origin_tile_x + xx;
	        var ty = origin_tile_y + yy;
	        var tile = tilemap_get(tilemap_id, tx, ty);

	        // Skip empty tiles
	        if (tile > 0) {
	            var dist = point_distance(x, y, tx * tile_size - tile_size / 2, ty * tile_size - tile_size / 2);
	            if (dist < nearest_dist) {
	                nearest_dist = dist;
	                nearest_tile_x = tx;
	                nearest_tile_y = ty;
	            }
	        }
	    }
	}
	
	// Calculate distance to nearest tile
	if (nearest_tile_x != -1) {
		var nearest_pixel_x = nearest_tile_x * tile_size;
		var nearest_pixel_y = nearest_tile_y * tile_size;
		var _dist_to_water = distance_to_point(nearest_pixel_x, nearest_pixel_y);
		if (_tilemap == "water_back") _dist_to_water *= 1.5;
		else if (_tilemap == "water_windows") _dist_to_water *= 2;
		return _dist_to_water;
	}
	return nearest_dist; // If no tiles were found
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