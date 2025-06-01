switch(state) {
	case swan_state.IDLE:	idle();	break;
	case swan_state.POSE:	pose();	break;
}

function idle(){
	sprite_index = sprSwanIdle;	
}


function pose(){
	if (floor(image_index == 0)) sprite_index = sprSwanPoseLeft;
	if (floor(image_index == 10)){
		image_speed = 0;
		alarm[1] = random(60);
	}
	if (image_index >= image_number-1){
		set_idle();
	}
}

function set_idle(){
	alarm[0] = idle_timer + random_range(0, idle_timer);
	state = swan_state.IDLE;	
}