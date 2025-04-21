// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

/// @function                   screenshake(_time, _magnitude, _fade);
/// @param  {real}  _time       The length of time - in steps - to shake the screen
/// @param  {real}  _magnitude  The amount of screenshake to apply
/// @param  {real}  _fade       How quickly the screenshake effect will fade out
/// @description    Set the screenshake object variables.

function screenshake(_time, _magnitude, _fade){
   with (objCam) {
      shake = true;
      shake_time = _time;
      shake_magnitude = _magnitude;
      shake_fade = _fade;
   }
}

function draw_sprite_custom(sprite){
	draw_sprite_ext(sprite, image_index, x, y, image_xscale, image_yscale, 0, c_white, 1);
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
