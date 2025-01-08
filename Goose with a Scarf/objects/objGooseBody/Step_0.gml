/// @description Insert description here
// You can write your code in this editor

switch (state){
	case player_state.MOVE: move(); break;
	case player_state.PAUSE: break;	
}

function move(){
	if (keyboard_check(ord("D"))) and (!check_collision(spd, 0)){
		spd = min(max(deceleration, spd*acceleration), top_spd);
		hspeed = spd;
		move_dir = dir.RIGHT;
	}
	else if (keyboard_check(ord("A"))) and (!check_collision(-spd, 0)){
		spd = min(max(deceleration, spd*acceleration), top_spd);
		hspeed = -spd;
		move_dir = dir.LEFT;
	}
	else {
		if (spd > 1) spd = max(0, spd*deceleration);
		else spd = 0;
		hspeed = move_dir * spd;
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