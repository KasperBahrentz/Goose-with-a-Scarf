// draw_gui event
switch(state){
	case gui_state.MOVE_IN:		move_in();	break;
	case gui_state.STAY:		stay();		break;
	case gui_state.MOVE_OUT:	move_out();	break;
}

// y is fixed relative to top of GUI
y = 32 * pixel_size;

function move_in(){
	var _target_x = display_get_gui_width() - 24 * pixel_size;
	x = lerp(x, _target_x, 0.1);
	
	if (abs(x - _target_x) <= 0.1){
		alarm[0] = 120;	
		state = gui_state.STAY;	
	}
}

function stay(){
	x = display_get_gui_width() - 24 * pixel_size;
}

function move_out(){
	x = lerp(x, start_x, 0.1);	
	
	if (abs(x - start_x) <= 0.1){
		instance_destroy();
	}
}