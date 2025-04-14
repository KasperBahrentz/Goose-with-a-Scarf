switch (state){
	case egg_state.MOVE: move(); break;
	case egg_state.DROP: drop(); break;
}


function move(){
	index = 1 + array_find_index(objGooseBody.egg_queue, function(_element, _index){
	    return (_element == egg_id);
	}, -1, -infinity);
	
	if (array_length(my_queue) > 6*index){ // Change position in room based on current position in array
	
		// Get the oldest stored position
		var _pos = array_pop(my_queue);
		var _offset = 0;
		var _target_x = _pos[0];
		var _target_y = _pos[1];

		// Calculate distance to the player
		var _dist_x = abs(objGooseBody.x - x);	
		var _dist_y = abs(objGooseBody.y - y);	

		// Move
		x = lerp(x, _target_x, 0.5);
		y = lerp(y, _target_y, 0.5);
	}
}

function drop(){
	if (check_collision(0, 0) or place_meeting(x, y, objCollisionSemiSolid)) and (!has_collided){ // Destroy on ground
		map_y = tilemap_get_cell_y_at_pixel(objGame.collision_tilemap, x, y + 4*objGame.pixel_size);
		vspeed = 0;
		
		audio_sound_pitch(sndThumb, random_range(0.9, 1.1));
		audio_play_sound(sndThumb, 5, false);
		
		repeat(choose(1, 2, 2, 2, 3)){ // Down
			instance_create_layer(x, (map_y * objGame.tile_size)-4*objGame.pixel_size, "instances", objEggShell, {shell_id: "down"});	
		}
		repeat(choose(1, 2, 2, 2, 3)){ // Left
			instance_create_layer(x, (map_y * objGame.tile_size)-4*objGame.pixel_size, "instances", objEggShell, {shell_id: "left"});	
		}
		repeat(choose(1, 2, 2, 2, 3)){ // Right
			instance_create_layer(x, (map_y * objGame.tile_size)-4*objGame.pixel_size, "instances", objEggShell, {shell_id: "right"});	
		}
		instance_create_layer(x, y, "instances", objEggRespawn, {egg_id : egg_id});
		instance_destroy();
	}
	else if (!has_collided){
		y += 32;	// Fall
	}
	
	if (y > room_height){
		instance_create_layer(x, y, "instances", objEggRespawn, {egg_id : egg_id});
		instance_destroy();
	}
}