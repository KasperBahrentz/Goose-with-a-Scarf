/// @description Insert description here
// You can write your code in this editor

switch (state){
	case player_state.MOVE: move(); break;
	case player_state.PAUSE: break;	
}

function move(){
	// Screen shake test
	if (keyboard_check_pressed(ord("M"))){
		screenshake(15, 3, 0.3);	
	}
	
	// Egg drop
	if (array_length(egg_queue) >= 1) and (keyboard_check_pressed(vk_space)){
		var _egg_id = array_pop(egg_queue);
		for (var i = 0; i < instance_number(objEgg); i++){
			var _inst = instance_find(objEgg, i);
			if (_inst.egg_id = _egg_id){
				with(_inst) instance_destroy();	
			}
		}
	}
	
	// Move horizontally
	var _key_right = keyboard_check(ord("D"));
	var _key_left = keyboard_check(ord("A"));
	var _moving = (_key_right - _key_left) != 0;
	
	// Add the player's current position to the queue
	with(objEgg) array_insert(my_queue, 0, [other.x, other.y]);
	
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
	
	if (_moving){ // Accelerate
		h_spd = min(max(deceleration, h_spd*acceleration), h_top_spd);
	}
	else { // Decelerate
		if (h_spd > 1) h_spd = max(0, h_spd*deceleration);
		else h_spd = 0;
	}
	
	if (check_collision(h_top_spd * move_dir, 0)){ // Stop
		map_x = tilemap_get_cell_x_at_pixel(objGame.collision_tilemap, x, y);
		if (move_dir == dir.RIGHT) map_x++;
		hspeed = 0;
		x = (map_x * objGame.tile_size) - spr_bbox_right*move_dir - objGame.pixel_size*move_dir;
	}
	else { // Move
		hspeed = h_spd * move_dir;	
	}
	
	
	// Move vertically
	
	var _ceiling_hit =  check_collision(0, -10*objGame.pixel_size);
	
	if (check_collision(0, 4*objGame.pixel_size)){ // Stop
		map_y = tilemap_get_cell_y_at_pixel(objGame.collision_tilemap, x, y + 4*objGame.pixel_size);
		vspeed = 0;
		y = (map_y * objGame.tile_size);
		
		if (keyboard_check_pressed(vk_space)){
			jump_timer = 0;
		}
	} 
	else if (vspeed < 0) and (_ceiling_hit){ // Stop at ceiling
		map_y = tilemap_get_cell_y_at_pixel(objGame.collision_tilemap, x, y-8*objGame.pixel_size) + 1;
		vspeed = 0;
		y = (map_y * objGame.tile_size);
	}
	else { // Move
		vspeed = grav;	
	}
	
	if (!_ceiling_hit) and (jump_timer < max_jump_timer){
		vspeed -= jump_height * (1 - jump_timer/max_jump_timer);
		jump_timer++;	
	} else jump_timer = max_jump_timer;

	if (hspeed != 0){ // Change to running sprite
		if (image_index <= 1) sprite_index = spr_body_run;
		objGooseFeet.sprite_index = spr_feet_run;
	}
	else { // Change to idle sprite
		if (image_index <= 1) sprite_index = spr_body_idle;
		objGooseFeet.sprite_index = spr_feet_idle;
	}
}