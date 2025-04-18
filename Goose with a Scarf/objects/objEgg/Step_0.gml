switch (state){
	case egg_state.IDLE: idle(); break;
	case egg_state.MOVE: move(); break;
	case egg_state.DROP: drop(); break;
}

function idle(){
	if (point_distance(x, y, objGooseBody.x, objGooseBody.y) <= 8*objGame.pixel_size){
		depth = start_depth-1;
		just_picked_up = true;
		audio_sound_pitch(sndPop, 0.85 + egg_id*0.01);
		audio_play_sound(sndPop, 5, false);
		state = egg_state.MOVE;
		with (instance_nearest(x, y, objNest)) nest_id = other.egg_id; // Set nest_id to egg_id
		add_to_egg_queue();
	}
}


function move(){
	index = 1 + array_find_index(objGooseBody.egg_queue, function(_element, _index){
	    return (_element == egg_id);
	});
	
	
	if (just_picked_up){ // Move egg immediately to its position
		// Move
		var _target_y = start_y - 8*objGame.pixel_size;
		y = lerp(y, _target_y, 0.25);
	}
	
	if (array_length(my_queue) > 6*index){ // Change position in room based on current position in array
		just_picked_up = false;
		// Get the oldest stored position
		var _pos = array_pop(my_queue);
		var _offset = 0;
		var _target_x = _pos[0];
		var _target_y = _pos[1];

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
		instance_create_layer(x, y, "instances", objEggRespawn, {egg_id : egg_id, spawn_at_nest : temporary, spawn_coordinate : spawn_coordinate, temporary_index : temporary_index});
		instance_destroy();
	}
	else if (!has_collided){
		y += 32;	// Fall
	}
	
	if (y > room_height){
		instance_create_layer(x, y, "instances", objEggRespawn, {egg_id : egg_id, spawn_at_nest : temporary, spawn_coordinate : spawn_coordinate, temporary_index : temporary_index});
		instance_destroy();
	}
}