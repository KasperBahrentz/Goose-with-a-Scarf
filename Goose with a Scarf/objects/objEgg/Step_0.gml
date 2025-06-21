switch (state){
	case egg_state.IDLE: idle(); break;
	case egg_state.MOVE: move(); break;
	case egg_state.DROP: drop(); break;
}

function idle(){
	if (distance_to_object(objGooseBody) <= 12*pixel_size) or (distance_to_object(objEgg) <= 12*pixel_size){
		depth = start_depth-1;
		just_picked_up = true;
		audio_sound_pitch(sndPop, 0.9 + array_length(objGooseBody.egg_queue)*0.05);
		audio_play_sound(sndPop, 5, false);
		state = egg_state.MOVE;
		with (instance_nearest(x, y, objNest)) nest_id = other.egg_id; // Set nest_id to egg_id
		add_to_egg_queue();
	}
}

function move(){
	if (objGooseBody.state == player_state.DIE){
		instance_destroy();	
	}


	index = 1 + array_find_index(objGooseBody.egg_queue, function(_element, _index){
	    return (_element == egg_id);
	});
	
	depth = start_depth + index;
	
	
	if (just_picked_up){ // Move egg immediately to its position
		// Move
		var _target_y = start_y - 8*pixel_size;
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
	if (!has_created_respawn){
		instance_create_layer(x, y, "instances", objEggRespawn, {egg_id : egg_id, spawn_at_nest : temporary, spawn_coordinate : spawn_coordinate, temporary_index : temporary_index});	
		has_created_respawn = true;
	}
	// Check ground collision
	if (check_collision(0, 0) or place_meeting(x, y, objCollisionSemiSolid)) and (!has_collided){ // Destroy on ground
		var _material = get_material();
		
		if (place_meeting(x, y, objCollisionSemiSolid)){
			if (_material == "water") repeat(irandom_range(5, 10)) instance_create_layer(x, y, "instances", objParticleWater);	
			play_material_sound(_material);
		}
		
		map_y = tilemap_get_cell_y_at_pixel(objGame.collision_tilemap, x, y + 4*pixel_size);
		vspeed = 0;
		
		audio_sound_pitch(sndThumb, random_range(0.9, 1.1));
		audio_play_sound(sndThumb, 5, false);
		
		var _color = "white";
		if (temporary){
			switch(image_index){
				case 1:	_color = "pink";	break;
				case 3: _color = "orange";	break;
				case 5: _color = "green";	break;
			}
		}
		
		repeat(choose(1, 2, 2, 2, 3)){ // Down
			instance_create_layer(x, (map_y * tile_size)-4*pixel_size, "instances", objEggShell, {shell_id: "down", color : _color});	
		}
		repeat(choose(1, 2, 2, 2, 3)){ // Left
			instance_create_layer(x, (map_y * tile_size)-4*pixel_size, "instances", objEggShell, {shell_id: "left", color : _color});	
		}
		repeat(choose(1, 2, 2, 2, 3)){ // Right
			instance_create_layer(x, (map_y * tile_size)-4*pixel_size, "instances", objEggShell, {shell_id: "right", color : _color});	
		}
		
		// Crate collisions
		if (place_meeting(x, y+8*pixel_size, prtCrate)){
			with instance_nearest(x, y, prtCrate){
				if (hp == 3){
					audio_sound_pitch(sndWoodCrack1, random_range(0.9, 1.1));
					audio_play_sound(sndWoodCrack1, 5, false);
				}
				else if (hp == 2){
					audio_sound_pitch(sndWoodCrack2, random_range(0.9, 1.1));
					audio_play_sound(sndWoodCrack2, 5, false);
				}
				hp--;
			}
		}
		
		instance_destroy();
	}
	else if (!has_collided){
		y += 32;	// Fall
	}
	
	if (y > room_height){
		instance_destroy();
	}
}