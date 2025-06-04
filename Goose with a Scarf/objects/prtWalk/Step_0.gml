switch(state){
	case walk_state.WALK_LEFT:	walk_left();	break;
	case walk_state.WALK_RIGHT:	walk_right();	break;
	case walk_state.WAIT:		wait();			break;
	case walk_state.EXIT_WAIT:	exit_wait();	break;
}

function walk_left(){
	sprite_index = walk_sprite;
	image_xscale = facing_right ? -1 : 1;
	
	set_walking_speed();

	
	if (x-xstart <= -walking_range){
		if (floor(image_index) == image_number-1){
			set_idle();
			next_state = walk_state.WALK_RIGHT;
		}
	}
	else x -= walking_speed;
}

function walk_right(){
	sprite_index = walk_sprite;
	image_xscale = facing_right ? 1 : -1;
	
	set_walking_speed();
	
	if (x-xstart >= walking_range) and (floor(image_index) == image_number-1){
		set_idle();
		next_state = walk_state.WALK_LEFT;
	}
	else x += walking_speed;
}

function set_idle(){
	state = walk_state.WAIT;	
	sprite_index = normal_sprite;
	image_index = 0;
	alarm[0] = wait_timer + random_range(0, wait_timer);	
	alarm[1] = irandom_range(10, wait_timer/2);
}

function wait(){
	
}

function exit_wait(){
	if (floor(image_index) == floor(image_number-1) or sprite_index == normal_sprite){
		if (alarm[2] == -1) alarm[2] = sprite_index == normal_sprite ? 4 : irandom_range(wait_timer/3, wait_timer/2);
		sprite_index = normal_sprite;
		image_index = 0;
	}
}

function set_walking_speed(){
	walking_speed = walking_speed_start;
	if (abs(x-xstart) >= walking_range/1.5) walking_speed = lerp(walking_speed, walking_speed_start/2, 0.5);
	if (abs(x-xstart) >= walking_range/1.25) walking_speed = lerp(walking_speed, walking_speed_start/4, 0.5);	
}

depth = objChimney.depth + 5;


