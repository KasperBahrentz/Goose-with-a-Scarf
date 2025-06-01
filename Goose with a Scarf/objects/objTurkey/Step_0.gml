switch(state){
	case turkey_state.WALK_LEFT:	walk_left();	break;
	case turkey_state.WALK_RIGHT:	walk_right();	break;
	case turkey_state.WAIT:		wait();			break;
}

function walk_left(){
	sprite_index = sprTurkeyWalk;
	image_xscale = -1;
	
	set_walking_speed();
	
	x -= walking_speed;
	
	if (abs(x-xstart) >= walking_range-4*pixel_size){
		set_idle();
		next_state = turkey_state.WALK_RIGHT;
	}
}

function walk_right(){
	sprite_index = sprTurkeyWalk;
	image_xscale = 1;
	
	set_walking_speed();
	
	x += walking_speed;
	
	if (abs(x-xstart) >= walking_range-4*pixel_size){
		set_idle();
		next_state = turkey_state.WALK_LEFT;
	}
}

function set_idle(){
	state = turkey_state.WAIT;	
	sprite_index = sprTurkey;
	image_index = 0;
	alarm[0] = wait_timer + random_range(0, wait_timer);	
	alarm[1] = irandom_range(10, wait_timer/2);
}

function wait(){

}

function set_walking_speed(){
	walking_speed = walking_speed_start;
	if (abs(x-xstart) >= walking_range/1.5) walking_speed = lerp(walking_speed, walking_speed_start/2, 0.5);
	if (abs(x-xstart) >= walking_range/1.25) walking_speed = lerp(walking_speed, walking_speed_start/4, 0.5);	
}

depth = objChimney.depth + 5;


