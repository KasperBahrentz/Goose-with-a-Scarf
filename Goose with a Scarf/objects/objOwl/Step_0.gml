/// @desc

switch(state){
	case owl_state.WAIT:		wait();		break;	
	case owl_state.BLINK:		blink();	break;	
	case owl_state.SLEEP:		sleep();	break;	
	case owl_state.EXIT_SLEEP:	exit_sleep();	break;	
}

function wait(){
	sprite_index = sprOwl;
	blink_timer--;
	if (blink_timer <= 0){
		state = owl_state.BLINK;
	}
	
}

function blink(){
	change_to_blink = false;
	sprite_index = sprOwlBlink;
	
	if (image_index >= 0.8){
		if (image_speed <= 0.2){
			state = owl_state.SLEEP;	
			blink_counter = 1;
		}	
	}
	
	if (floor(image_index) == image_number-1 and floor(last_image_index) == 0){
		if (blink_counter <= 1){
			state = owl_state.WAIT;
			blink_timer = irandom_range(300, 400);
			last_blink_timer = blink_timer;
			blink_counter = choose(1, 2);
			image_speed = image_speed / random_range(2, 4);
		}
		else blink_counter--;
	}
	last_image_index = image_index;
}


function sleep(){
	image_speed = 1;
	sprite_index = sprOwlIdle;
	if (alarm[0] <= 0) alarm[0] = random_range(600, 800);
	
	if (floor(image_index) == 0 and change_to_blink){
		state = owl_state.EXIT_SLEEP;	
	}
	
	if (z_timer <= 0){
		instance_create_layer(x-8*pixel_size, y-15*pixel_size, "instances", objZ);	
		z_timer = z_timer_max + irandom(z_timer_max/2);
	}
	else z_timer--;
}

function exit_sleep(){
	sprite_index = sprOwlIdleBlink;
	if (floor(image_index) == image_number-1) state = owl_state.WAIT;
}