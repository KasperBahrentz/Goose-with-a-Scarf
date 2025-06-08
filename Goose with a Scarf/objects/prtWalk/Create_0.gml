enum walk_state {
	WALK_LEFT,
	WALK_RIGHT,
	WAIT,
	EXIT_WAIT
}

state = choose(walk_state.WALK_LEFT, walk_state.WALK_RIGHT);

function set_idle(){
	state = walk_state.WAIT;	
	sprite_index = normal_sprite;
	image_index = 0;
	alarm[0] = wait_timer + random_range(0, wait_timer);	
	alarm[1] = irandom_range(10, wait_timer/2);
}

if (stationary){
	set_idle();
}
		

next_state = state;

walking_speed = walking_speed_start;