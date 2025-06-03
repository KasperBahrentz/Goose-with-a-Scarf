/// @description Insert description here
// You can write your code in this editor

switch(state){
	case keyboard_state.APPEAR:		appear();		break;	
	case keyboard_state.STAY:		stay();			break;	
	case keyboard_state.DISAPPEAR:	disappear();	break;	
}

function appear(){
	image_alpha = lerp(image_alpha, 1, 0.2);
}

function stay(){
	
}

function disappear(){
	image_alpha = lerp(image_alpha, 0, 0.2);
	if (image_alpha <= 0.01){
		instance_destroy();	
	}
}