/// @description Insert description here
// You can write your code in this editor

switch (state){
	case player_state.MOVE:		move(); break;
	case player_state.PAUSE:	break;	
}

function move(){
	// Screen shake test
	if (keyboard_check_pressed(ord("M"))){
		screenshake(15, 3, 0.3);	
	}
	
	if (!audio_is_playing(sndHonk)){
		objGooseHead.sprite_index = spr_head_idle;
		if (sprite_index == spr_body_crouch) image_index = 0;
	}
	
	// Move horizontally
	var _key_right = keyboard_check(ord("D"));
	var _key_left = keyboard_check(ord("A"));
	var _moving = (_key_right - _key_left) != 0;
	
	// Add the player's current position to the queue
	var _offset = 0;
	if (hspeed == 0 and vspeed == 0){
		//_offset = -image_xscale*8*objGame.pixel_size;
	}
	
	// Provide correct positions to the array of any given egg
	for (var i = 0; i < instance_number(objEgg); i++){
		var _inst = instance_find(objEgg, i);
		with(_inst){
			if (_inst.state = egg_state.MOVE) array_insert(my_queue, 0, [other.x + _offset - other.image_xscale*objGame.pixel_size, other.y]);
		}
	}
	
	if (_key_right){
		image_xscale = 1;
		move_dir = dir.RIGHT;	
	}
	else if (_key_left){
		image_xscale = -1;
		move_dir = dir.LEFT;	
	}
	
	if (move_dir != sign(hspeed)){
		h_spd = 0;	
	}
	
	var _top_spd = h_top_spd;
	if (sprite_index == spr_body_crouch) _top_spd = h_top_spd / 2;
	
	if (_moving){ // Accelerate
		h_spd = min(max(deceleration, h_spd*acceleration), _top_spd);
		
		if (grass_timer == 0){
			var _play_sound = random_range(0, 1);
		
			if (_play_sound >= 0.95){	
				play_grass_sound();
				grass_timer = grass_timer_max;
			}
		} else {
			grass_timer--;
		}
	}
	else { // Decelerate
		if (h_spd > 1) h_spd = max(0, h_spd*deceleration);
		else h_spd = 0;
	}
	
	if (check_collision(h_top_spd * move_dir, 0)){ // Stop
		map_x = tilemap_get_cell_x_at_pixel(objGame.collision_tilemap, x, y);
		if (move_dir == dir.RIGHT) map_x++;
		hspeed = 0;
		if (y > 0 ) x = (map_x * objGame.tile_size) - spr_bbox_right*move_dir - objGame.pixel_size*move_dir;
	}
	else { // Move
		hspeed = h_spd * move_dir;	
	}
	
	// Move vertically
	var _ceiling_hit =  check_collision(0, -10*objGame.pixel_size);
	
	var _landed_on_semi_solid = false;
		
	// Semi-solid platforms
	if (vspeed >= 0) and (place_meeting(x , y + 4*objGame.pixel_size, objCollisionSemiSolid)){
		_landed_on_semi_solid = true;
	}	
	
	if (_landed_on_semi_solid) or (check_collision(0, 4*objGame.pixel_size)){ // Stop on ground
		var _tilemap = objGame.collision_tilemap;
		if (_landed_on_semi_solid) _tilemap = layer_tilemap_get_id("back");
		map_y = tilemap_get_cell_y_at_pixel(_tilemap, x, y + 4*objGame.pixel_size);
		vspeed = 0;
		y = (map_y * objGame.tile_size);
		
		// If just landed
		if (was_in_air){
			play_grass_sound();
			spawn_dust();
			with(objEggRespawn) alarm[0] = 4;
			was_in_air = false;
			current_max_jump_timer = max_jump_timer;
		}
		
		// Crouch
		if (keyboard_check(ord("S"))){
			sprite_index = spr_body_crouch;
		}
		else {
			sprite_index = spr_body_idle;
		}
		
		was_on_ground_timer = was_on_ground_timer_max;
	} 
	else if (vspeed < 0) and (_ceiling_hit){ // Stop at ceiling
		map_y = tilemap_get_cell_y_at_pixel(objGame.collision_tilemap, x, y-8*objGame.pixel_size) + 1;
		jump_timer = max(jump_timer, current_max_jump_timer/2 + current_max_jump_timer/4);
		vspeed = max(vspeed - jump_height * (1 - jump_timer/current_max_jump_timer), 0);
		y = (map_y * objGame.tile_size);
	}
	else { // Move
		vspeed = grav;	
	}
	
	// If in air
	if (vspeed != 0){
		was_in_air = true;
		if (keyboard_check(ord("S"))){
			vspeed += grav/2;
		}
		
		was_on_ground_timer--;
		
	}
	
	// Jump
	if (was_on_ground_timer > 0) and (keyboard_check_pressed(vk_space)) and (sprite_index != spr_body_crouch){
		jump_timer = 0;
		current_max_jump_timer = max_jump_timer;
		spawn_dust();
			
		play_grass_sound();
			
		// Honk at random
		var _number = random_range(0, 1);
		if (_number >= 0.9) honk();
		
		was_on_ground_timer = 0;
	} else // Egg drop
	if (array_length(egg_queue) >= 1) and (keyboard_check_pressed(vk_space)) and (vspeed != 0){
		instance_create_layer(x, y, "instances", objWoosh);
		jump_timer = 0;
		current_max_jump_timer = egg_drop_max_jump_timer;
		screenshake(15, 3, 0.3);
		var _egg_id = array_shift(egg_queue);
		with(objEgg){
			repeat(6*index){
				array_pop(my_queue);
			}
		}
		
		for (var i = 0; i < instance_number(objEgg); i++){
			var _inst = instance_find(objEgg, i);
			if (_inst.egg_id == _egg_id){
				with(_inst){
					x = other.x;
					y = other.y;
					state = egg_state.DROP;
				}
			}
		}
		
		// Play woosh sound
		audio_sound_pitch(sndWoosh, random_range(1, 1.2));
		audio_play_sound(sndWoosh, 5, false);
		
		// Honk at random
		var _number = random_range(0, 1);
		if (_number >= 0.8) honk();
	}
	
	jump();

	if (sprite_index != spr_body_crouch){
		if (hspeed != 0) and (vspeed == 0){ // Change to running sprite
			if (image_index <= 1) sprite_index = spr_body_run;
			objGooseFeet.sprite_index = spr_feet_run;
		}
		else if (vspeed < 0){
			objGooseFeet.sprite_index = spr_feet_jump;	
		}
		else { // Change to idle sprite
			if (image_index <= 1) sprite_index = spr_body_idle;
			objGooseFeet.sprite_index = spr_feet_idle;
		}
	}
}

function jump(){
	if (jump_timer < current_max_jump_timer){
		vspeed -= jump_height * (1 - jump_timer/current_max_jump_timer);
		jump_timer++;	
	} else jump_timer = current_max_jump_timer;	
}

function spawn_dust(){
	repeat(choose(1, 1, 2)){ // Down
		instance_create_layer(x + random_range(-3, 3), y + random_range(0, 2), "instances", objDust, {dust_id: "down"});	
	}
	repeat(choose(1, 1, 2)){ // Left
		instance_create_layer(x + random_range(-7, 1), y + random_range(0, 2), "instances", objDust, {dust_id: "left"});	
	}
	repeat(choose(1, 1, 2)){ // Right
		instance_create_layer(x + random_range(-1, 7), y + random_range(0, 2), "instances", objDust, {dust_id: "right"});	
	}
}

function honk(){
	audio_sound_pitch(sndHonk, random_range(0.9, 1.1));
	audio_play_sound(sndHonk, 10, false);
	objGooseHead.sprite_index = spr_head_honk;
	if (sprite_index == spr_body_crouch){
		image_index = 1;
	}
}

function play_grass_sound(){
	var _grass_sound = choose(sndGrass1, sndGrass2, sndGrass3, sndGrass4, sndGrass5, sndGrass6, sndGrass7, sndGrass8);
	audio_sound_pitch(_grass_sound, random_range(0.9, 1.1));
	audio_play_sound(_grass_sound, 2, false);
}

var _dist_to_water = min(calc_dist_to_water("water_front"), calc_dist_to_water("water_windows"), calc_dist_to_water("water_back"));
change_water_audio_level(_dist_to_water);

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
	            var dist = point_distance(x, y, tx * objGame.tile_size - objGame.tile_size / 2, ty * objGame.tile_size - objGame.tile_size / 2);
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
		var nearest_pixel_x = nearest_tile_x * objGame.tile_size;
		var nearest_pixel_y = nearest_tile_y * objGame.tile_size;
		water_x = nearest_pixel_x;
		water_y = nearest_pixel_y;
		var _dist_to_water = distance_to_point(nearest_pixel_x, nearest_pixel_y);
		if (_tilemap == "water_back") _dist_to_water *= 1.5;
		else if (_tilemap == "water_windows") _dist_to_water *= 2;
		return _dist_to_water;
	}
	return nearest_dist; // If no tiles were found
}

function change_water_audio_level(_dist_to_water){
	var _gain = min(max(0.6, 500/_dist_to_water), 1.2);
	debug_string = _gain;
	audio_sound_gain(sndRunningWater, _gain, 0);
}