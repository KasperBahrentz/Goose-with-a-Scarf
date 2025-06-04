/// @description Insert description here
// You can write your code in this editor

switch(state){
	case keyboard_state.APPEAR:		appear();		break;	
	case keyboard_state.STAY:		stay();			break;	
	case keyboard_state.DISAPPEAR:	disappear();	break;	
}

function appear(){
	image_alpha = lerp(image_alpha, 1, 0.2);
	if (image_alpha >= 0.9){
		image_alpha = 1;
		state = keyboard_state.STAY;	
	}
}

function stay(){
	image_speed = 1;
	if (sprite_index == sprKeyWASD){
		if (keyboard_check_pressed(ord("D"))){
			state = keyboard_state.DISAPPEAR;	
		}
	}
}

function disappear(){
	image_speed = 0;
	image_alpha = lerp(image_alpha, 0, 0.2);
	if (image_alpha <= 0.1){
		instance_destroy();	
	}
}