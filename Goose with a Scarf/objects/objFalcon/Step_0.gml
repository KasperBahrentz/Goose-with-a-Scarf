switch(state) {
	case falcon_state.LOOK_RIGHT:		look_right();		break;	
	case falcon_state.LOOK_STRAIGHT:	look_straight();	break;		
	case falcon_state.LOOK_RIGHT_AGAIN:	look_right_again();	break;		
}

function look_right() {
	sprite_index = sprFalcon;
	if (alarm[0] == -1) alarm[0] = random_range(look_right_time, look_right_time*2);	
}

function look_straight() {
	sprite_index = sprFalconIdle;
	if (image_index >= 2) image_speed = 0;
	if (alarm[1] == -1) alarm[1] = random_range(look_straight_time, look_straight_time*2);	
}

function look_right_again() {
	image_speed = img_spd;
	if (image_index >= image_number-1) state = falcon_state.LOOK_RIGHT;
}