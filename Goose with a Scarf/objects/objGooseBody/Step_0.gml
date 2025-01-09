/// @description Insert description here
// You can write your code in this editor

switch (state){
	case player_state.MOVE: move(); break;
	case player_state.PAUSE: break;	
}

function move(){
	
	if (check_collision(0, 32)){
		map_y = tilemap_get_cell_y_at_pixel(objGame.collision_tilemap, x, y + 32);
		vspeed = 0;
		y = (map_y * tile_size);
		
		if (keyboard_check_pressed(vk_space)){
			has_jumped = true;	
			jump_timer = 0;
		}
	}
	else {
		vspeed = grav;	
	}

	
	if (has_jumped){
		if (jump_timer >= max_jump_timer){
			
		}
		else {
			vspeed -= jump_height * (1 - jump_timer/max_jump_timer);
			jump_timer++;	
		}
	} 	

	if (keyboard_check(ord("D"))){
		image_xscale = 1;
		if (check_collision(h_top_spd, vspeed)){
			map_x = tilemap_get_cell_x_at_pixel(objGame.collision_tilemap, x, y) + 1;
			hspeed = 0;
			x = (map_x * tile_size) - spr_bbox_right - pixel_size;
		}
		else {
			hspeed = min(max(deceleration, hspeed*acceleration), h_top_spd);
			move_dir = dir.RIGHT;
		}
	}
	else if (keyboard_check(ord("A"))){
		image_xscale = -1;	
		if (check_collision(-h_top_spd, vspeed)){
			map_x = tilemap_get_cell_x_at_pixel(objGame.collision_tilemap, x, y);
			hspeed = 0;
			x = (map_x * tile_size) - spr_bbox_left;
		}
		else {
			hspeed = min(max(-deceleration, -hspeed*acceleration), -h_top_spd);
			move_dir = dir.LEFT;
		}
	}
	else {
		if (move_dir == dir.RIGHT) and (hspeed > 1) hspeed = max(0, hspeed*deceleration);
		else if (move_dir == dir.LEFT) and (hspeed > 1) hspeed = max(0, hspeed*deceleration);
		else hspeed = 0;
		hspeed = move_dir * hspeed;
	}

	if (hspeed != 0){
		if (image_index <= 1) sprite_index = spr_body_run;
		objGooseFeet.sprite_index = spr_feet_run;
	}
	else{
		if (image_index <= 1) sprite_index = spr_body_idle;
		objGooseFeet.sprite_index = spr_feet_idle;
	}
}