/// @description Insert description here
// You can write your code in this editor

if (keyboard_check(ord("D"))){
	hspeed = spd;
}
else if (keyboard_check(ord("A"))){
	hspeed = -spd;
}
else {
	hspeed = 0;	
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