var _min_distance = 12 * objGame.pixel_size; // Set the stopping distance
var _max_lerp_factor = 0.6;  // Max interpolation speed
var _min_lerp_factor = 0.05; // Min interpolation speed when close to the target

// Ensure there's data in the queue
if (array_length(objGooseBody.follow_queue) > 12){
    // Get the oldest stored position
    var _pos = array_pop(objGooseBody.follow_queue);
    var _target_x = _pos[0];
    var _target_y = _pos[1];

    // Calculate distance to the player
    var _dist_x = abs(objGooseBody.x - x);	
	var _dist_y = abs(objGooseBody.y - y);	

	
	var _lerp_factor_x = _max_lerp_factor * (_dist_x/(100 * objGame.pixel_size)); // 100 is an arbitrary max distance threshold for scaling
    _lerp_factor_x = clamp(_lerp_factor_x, _min_lerp_factor, _max_lerp_factor);  // Ensure the lerp factor stays within bounds

	
	var _lerp_factor_y = _max_lerp_factor * (_dist_y/(100 * objGame.pixel_size)); // 100 is an arbitrary max distance threshold for scaling
    _lerp_factor_y = clamp(_lerp_factor_x, _max_lerp_factor/3, _max_lerp_factor);  // Ensure the lerp factor stays within bounds
	
    // Only move if the follower is farther than the min distance
    if (_dist_x > _min_distance){
		if (!check_collision(sign(_target_x - x)*objGame.pixel_size, -8)){
			x = lerp(x, _target_x, _lerp_factor_x);
		}
	
		// Check if there's no collision below the follower before moving in the Y direction
	    if (!check_collision(0,  sign(_target_y - y)*objGame.pixel_size)){
	        y = lerp(y, _target_y, _lerp_factor_y);
	    } else {
			//if (objGooseBody.vspeed != 0) x = lerp(x, _target_x, _lerp_factor_x*2);
			var _map_y = tilemap_get_cell_y_at_pixel(objGame.collision_tilemap, x, y + 4*objGame.pixel_size);
			y = (_map_y * objGame.tile_size);
		}
	}
	
	if (abs(x - _target_x) < 1*objGame.pixel_size) x = _target_x;
	if (abs(y - _target_y) < 1*objGame.pixel_size) y = _target_y;
	
	if (_dist_x <= _min_distance) and (!check_collision(0,  1)*objGame.pixel_size){
		y += objGooseBody.grav;
		if (check_collision(0, 0)){
			y = tilemap_get_cell_y_at_pixel(objGame.collision_tilemap, x, y)*objGame.tile_size;
		}
	} else if (_dist_x <= _min_distance) and (_dist_y == 0){
        array_resize(objGooseBody.follow_queue, 0); // Clear the queue
    }
}