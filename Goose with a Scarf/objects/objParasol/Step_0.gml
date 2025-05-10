/// @description Insert description here
// You can write your code in this editor

switch(state){
	case parasol_state.CLOSED:	closed();	break;
	case parasol_state.OPEN:	open();		break;
}

function closed(){
	event_inherited();

	if (place_meeting(x, y, objGooseBody) and objGooseBody.parasol == noone){
		objGooseBody.parasol = self;
		state = parasol_state.OPEN;	
		image_index = objGooseBody.image_xscale == 1 ? sprite_state.OPEN_RIGHT: sprite_state.OPEN_LEFT;
	}
}

function open(){
	if (objGooseBody.vspeed == 0){
		state = parasol_state.CLOSED;
		//var _x = x + random_range(-5, 5)*pixel_size;
		//var _y = y + random_range(-10, 5)*pixel_size;
		//repeat(random_range(4,5)) instance_create_layer(_x, _y, "instances", objDust);
		image_index = sprite_state.ITEM;
		objGooseBody.parasol = noone;
	}
	else {	
		if (keyboard_check(vk_space)){
			image_index = objGooseBody.image_xscale == 1 ? sprite_state.OPEN_RIGHT: sprite_state.OPEN_LEFT;
		}
		else {
			image_index = objGooseBody.image_xscale == 1 ? sprite_state.CLOSED_RIGHT: sprite_state.CLOSED_LEFT;
		}
	}
}