/// @description Insert description here
// You can write your code in this editor

switch (state){
	case player_state.MOVE: move(); break;
	case player_state.PAUSE: break;	
}

function move(){
	
	// Move horizontally
	var _key_right = keyboard_check(ord("D"));
	var _key_left = keyboard_check(ord("A"));
	var _moving = (_key_right - _key_left) != 0;
	
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
		x = (map_x * tile_size) - spr_bbox_right*move_dir - pixel_size*move_dir;
	}
	else { // Move
		hspeed = h_spd * move_dir;	
	}
	
	// Move vertically
	if (check_collision(0, 32)){ // Stop
		map_y = tilemap_get_cell_y_at_pixel(objGame.collision_tilemap, x, y + 32);
		vspeed = 0;
		y = (map_y * tile_size);
		
		if (keyboard_check_pressed(vk_space)){
			jump_timer = 0;
		}
	}
	else { // Move
		vspeed = grav;	
	}

	if (jump_timer <= max_jump_timer){
		vspeed -= jump_height * (1 - jump_timer/max_jump_timer);
		jump_timer++;	
	}

	if (hspeed != 0){ // Change to running sprite
		if (image_index <= 1) sprite_index = spr_body_run;
		objGooseFeet.sprite_index = spr_feet_run;
	}
	else { // Change to idle sprite
		if (image_index <= 1) sprite_index = spr_body_idle;
		objGooseFeet.sprite_index = spr_feet_idle;
	}
}