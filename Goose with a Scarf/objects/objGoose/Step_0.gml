/// @description Insert description here
// You can write your code in this editor

if (keyboard_check(ord("D"))){
	speed = spd;
}
else if (keyboard_check(ord("A"))){
	speed = -spd;
}
else {
	speed = 0;	
}

if (hspeed != 0){
	if (image_index == 2){
		spr_body = spr_body_run;	
	}
	spr_feet = spr_feet_run;
}
else{
	spr_body = spr_body_idle;
	spr_feet = spr_feet_idle;
}

if (hspeed < 0){
	image_xscale = -1;	
}
else if (hspeed > 0){
	image_xscale = 1;	
}