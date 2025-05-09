// @description Insert description here
// You can write your code in this editor

switch (state){
	case player_state.MOVE:		move(); break;
	case player_state.PAUSE:	break;	
}

function move(){
	vspeed = grav;
	
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
	
	// Provide correct positions to the array of any given egg
	for (var i = 0; i < instance_number(objEgg); i++){
		var _inst = instance_find(objEgg, i);
		with(_inst){
			if (_inst.state = egg_state.MOVE) array_insert(my_queue, 0, [other.x - other.image_xscale*pixel_size, other.y]);
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
		
		if (sound_timer == 0){
			var _play_sound = random_range(0, 1);
		
			if (_play_sound >= 0.9){	
				play_material_sound();
				sound_timer = sound_timer_max;
			}
		} else {
			sound_timer--;
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
		if (y > 0 ) x = (map_x * tile_size) - spr_bbox_right*move_dir - pixel_size*move_dir;
	}
	else { // Move
		hspeed = h_spd * move_dir;	
	}
	
	// Move vertically
	var _landed_on_semi_solid = false;
		
	// Semi-solid platforms
	if (vspeed >= 0) and (place_meeting(x , y + 4*pixel_size, objCollisionSemiSolid)){
		_landed_on_semi_solid = true;
	}
	
	var _ceiling_hit =  check_collision(0, -10*pixel_size);
	if (_landed_on_semi_solid) or (check_collision(0, 4*pixel_size)){ // Stop on ground
		var _tilemap = objGame.collision_tilemap;
		if (_landed_on_semi_solid) _tilemap = layer_tilemap_get_id("back");
		map_y = tilemap_get_cell_y_at_pixel(_tilemap, x, y + 4*pixel_size);
		vspeed = 0;
		y = (map_y * tile_size);
		
		// If just landed
		if (was_in_air){
			play_material_sound();
			spawn_dust();
			with(objEggRespawn) alarm[0] = 4;
			was_in_air = false;
			current_max_jump_timer = max_jump_timer;
		}
		
		// Crouch
		if (keyboard_check(ord("S"))){
			sprite_index = spr_body_crouch;
		}
		else if (keyboard_check_released(ord("S"))){
			sprite_index = spr_body_idle;
		}
		
		was_on_ground_timer = was_on_ground_timer_max;
	} 
	else if (_ceiling_hit){ // Stop at ceiling
		map_y = tilemap_get_cell_y_at_pixel(objGame.collision_tilemap, x, y-8*pixel_size) + 1;
		jump_timer = max(jump_timer, current_max_jump_timer/2 + current_max_jump_timer/4);
		vspeed = max(vspeed - jump_height * (1 - jump_timer/current_max_jump_timer), 0);
		y = (map_y * tile_size) + pixel_size;
	}
	
	// Jump
	if (was_on_ground_timer > 0) and (keyboard_check_pressed(vk_space)) and (sprite_index != spr_body_crouch){
		glide_timer = glide_timer_max;
		jump_timer = 0;
		current_max_jump_timer = max_jump_timer;
		spawn_dust();
			
		play_material_sound();
			
		// Honk at random
		var _number = random_range(0, 1);
		if (_number >= 0.9) honk();
		
		was_on_ground_timer = 0;
	} else // egg drop
	if (array_length(egg_queue) >= 1) and (keyboard_check_pressed(vk_space)) and (vspeed != 0){	
		glide_timer = glide_timer_max;
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
	
	// If in air
	if (vspeed != 0){
		was_in_air = true;
		if (keyboard_check(ord("S"))){
			vspeed += (grav/2);
		}
		
		was_on_ground_timer--;		
		
		// Gliding
		if (keyboard_check(vk_space) and glide_timer > 0){
			if (vspeed >= grav){
				vspeed -= grav*0.8;
				if (parasol == noone) glide_timer--;
				sprite_index = spr_body_glide;
			}
			else {
				vspeed -= (grav/2);
			}
		}
		else {
			sprite_index = spr_body_idle;
			if (keyboard_check_released(vk_space)){
				glide_timer = 0;	
			}
		}
	}
	else if (glide_timer > 0){ // If we landed but still have time on the timer
		glide_timer = 0;
		sprite_index = spr_body_idle;		
	}

	if (sprite_index != spr_body_crouch){
		if (hspeed != 0) and (vspeed == 0){ // Change to running sprite
			if (image_index <= 1) sprite_index = spr_body_run;
			objGooseFeet.sprite_index = spr_feet_run;
		}
		else if (vspeed < 0 or glide_timer > 0) {
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

function play_material_sound(){
	var _material = "grass";
	var _sound = sndGrass1;
	
	// If there is a different  material below us
	if (place_meeting(x , y + 4*pixel_size, objCollisionSemiSolid)){
		var _semi_solid = instance_nearest(x, y, objCollisionSemiSolid);
		if (_semi_solid.material == "water"){
			_material = "water"
		} else if (_semi_solid.material == "wood"){
			_material = "wood";
		}
	}
	else if (place_meeting(x, y + 4*pixel_size, prtCrate)){
		_material = "wood";
	}
	
	switch(_material){
		case "grass": {
			_sound = choose(sndGrass1, sndGrass2, sndGrass3, sndGrass4, sndGrass5, sndGrass6, sndGrass7, sndGrass8);
			audio_sound_gain(_sound, 2, 0);
			break;
		}
		case "water": {
			_sound = sndWater2;
			audio_sound_gain(_sound, 2, 0);	
			break;
		}
		case "wood": {
			_sound = choose(sndWood1, sndWood2, sndWood3, sndWood4, sndWood5);
			audio_sound_gain(_sound, 3, 0);	
			break;
		}
	}
	
	audio_sound_pitch(_sound, random_range(0.9, 1.1));
	audio_play_sound(_sound, 1.8, false);
}


if (water_timer >= water_timer_max){ // Change how often to check for distance to water and hidden blocks
	var _dist_to_water = min(calc_dist_to_water("water_front"), calc_dist_to_water("water_windows"), calc_dist_to_water("water_back"));
	change_water_audio_level(_dist_to_water);
	water_timer = 0;
}
else water_timer++;

function change_water_audio_level(_dist_to_water){
	var _gain = min(max(0.6, 500/_dist_to_water), 1.2);
	debug_string = _gain;
	audio_sound_gain(sndRunningWater, _gain, 0);
}

// Check if player is colliding with any hidden blocks
for (var i = 0; i < array_length(hidden_assets); i++){
	hidden_block_id = hidden_assets[i];
	var _x = layer_sprite_get_x(hidden_block_id);
	var _y = layer_sprite_get_y(hidden_block_id);
	if (layer_sprite_get_alpha(hidden_block_id) <= 0){
		array_delete(hidden_assets, array_get_index(hidden_assets, hidden_block_id), 1);
	}
	else if (collision_rectangle(_x, _y, _x+128, _y+128, self, false, false)){ // Check for collision with player
		audio_sound_pitch(sndWooshHidden, random_range(0.9, 1.1));
		if (array_length(found_hidden_blocks) == 0) audio_play_sound(sndWooshHidden, 7, false);
		array_push(found_hidden_blocks, hidden_block_id);
	} 
}

// Check if hidden blocks are next to other hidden_blocks
for (var i = 0; i < array_length(found_hidden_blocks); i++){
	hidden_block_id = found_hidden_blocks[i];
	var _my_x =  layer_sprite_get_x(hidden_block_id);
	var _my_y =  layer_sprite_get_y(hidden_block_id);
	
	for (var j = 0; j < array_length(hidden_assets); j++){
		var _element_to_add_id = hidden_assets[j];
		var _x = layer_sprite_get_x(_element_to_add_id);
		var _y = layer_sprite_get_y(_element_to_add_id);
		if (point_distance(_my_x, _my_y, _x, _y) <= tile_size) and (!array_contains(found_hidden_blocks, _element_to_add_id)){	
			array_push(found_hidden_blocks, _element_to_add_id);
		}
	}
	
	// Remove block from foun dhidden blocks array
	var _current_alpha = layer_sprite_get_alpha(hidden_block_id);
	if (_current_alpha <= 0){
		array_delete(found_hidden_blocks, array_get_index(found_hidden_blocks, found_hidden_blocks), 1);
	}
	else {
		layer_sprite_alpha(hidden_block_id, lerp(_current_alpha, 0, 0.2));
	}
}