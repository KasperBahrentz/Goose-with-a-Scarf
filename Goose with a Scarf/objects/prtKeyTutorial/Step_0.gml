/// @description Insert description here
// You can write your code in this editor

switch(state){
	case keyboard_state.APPEAR:		appear();		break;	
	case keyboard_state.STAY:		stay();			break;	
	case keyboard_state.DISAPPEAR:	disappear();	break;	
	case keyboard_state.WAIT:		wait();			break;	
}

function appear(){
	remove_if_key_pressed();
	image_alpha = lerp(image_alpha, 1, 0.2);
	if (image_alpha >= 0.9){
		image_alpha = 1;
		state = keyboard_state.STAY;	
	}
}

function stay(){
	image_speed = 1;
	remove_if_key_pressed();
}

function disappear(){
	image_speed = 0;
	image_alpha = lerp(image_alpha, 0, 0.2);
	if (image_alpha <= 0.1){
		instance_destroy();	
	}
}

function wait(){
	remove_if_key_pressed();
	if (point_distance(x, 0, objGooseBody.x, 0) <= 16*pixel_size){
		if (alarm[0] <= 0) alarm[0] = wait_time;
	}
}

function remove_if_key_pressed(){
	switch(sprite_index){
		case sprKeyWASD:		if (check_moved_sideways())				state = keyboard_state.DISAPPEAR;	break;
		case sprKeySpace:		if (keyboard_check_pressed(vk_space))	state = keyboard_state.DISAPPEAR;	break;
		case sprKeySpaceHold:	if (check_space_hold())					state = keyboard_state.DISAPPEAR;	break;
	}		
}

function check_moved_sideways(){
	if (keyboard_check_pressed(ord("D")) or keyboard_check_pressed(ord("A"))){
		return true;	
	}
	else return false;
}	

function check_space_hold(){
	if (objGooseBody.glide_timer <= objGooseBody.glide_timer_max/2 and objGooseBody.glide_timer >= objGooseBody.glide_timer_max/3){
		return true;	
	}
	else return false;
}