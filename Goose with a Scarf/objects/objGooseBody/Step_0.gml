/// @description Insert description here
// You can write your code in this editor

switch (state){
	case player_state.MOVE: move(); break;
	case player_state.PAUSE: break;	
}

function move(){
	v_spd = grav;
	y += v_spd;	
	
	if (check_collision(0, v_spd)){
		map_y = tilemap_get_cell_y_at_pixel(objGame.collision_tilemap, x, y);
		y = (map_y * tilesize);
	}

	if (keyboard_check(ord("D"))){
		if (check_collision(h_spd, v_spd)){
			map_x = tilemap_get_cell_x_at_pixel(objGame.collision_tilemap, x, y);
			x = (map_x * tilesize);
			h_spd = 0;
		}
		else {
			h_spd = min(max(deceleration, h_spd*acceleration), top_spd);
			hspeed = h_spd;
			move_dir = dir.RIGHT;
		}
	}
	else if (keyboard_check(ord("A"))) and (!check_collision(-h_spd, v_spd)){
		h_spd = min(max(deceleration, h_spd*acceleration), top_spd);
		hspeed = -h_spd;
		move_dir = dir.LEFT;
	}
	else {
		if (h_spd > 1) h_spd = max(0, h_spd*deceleration);
		else h_spd = 0;
		hspeed = move_dir * h_spd;
	}

	if (hspeed != 0){
		if (image_index <= 1) sprite_index = spr_body_run;
		objGooseFeet.sprite_index = spr_feet_run;
	}
	else{
		if (image_index <= 1) sprite_index = spr_body_idle;
		objGooseFeet.sprite_index = spr_feet_idle;
	}

	if (hspeed < 0){
		image_xscale = -1;	
	}
	else if (hspeed > 0){
		image_xscale = 1;	
	}	
}