/// @description Insert description here
// You can write your code in this editor

switch(state){
	case gui_state.MOVE_IN:		move_in();	break;
	case gui_state.STAY:		stay();		break;
	case gui_state.MOVE_OUT:	move_out();	break;
}

y = camera_get_view_y(cam) + 16 * pixel_size;

function move_in(){
	var _target_x = camera_get_view_x(cam) + camera_get_view_width(cam) - 24 * pixel_size;
	
	x = lerp(x, _target_x, 0.1);	
	
	if (abs(x - _target_x) <= 0.1){
		alarm[0] = 120;	
		state = gui_state.STAY;	
	}
}

function stay(){
	x = camera_get_view_x(cam) + camera_get_view_width(cam) - 24 * pixel_size;
}

function move_out(){
	x = lerp(x, start_x, 0.1);	
	
	if (abs(x - start_x) <= 0.1){
		instance_destroy();
	}
}