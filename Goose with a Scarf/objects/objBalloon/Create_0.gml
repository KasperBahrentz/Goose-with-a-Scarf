if (instance_exists(objGame) and objGame.has_arrived_in_level) instance_destroy();
else {
	// Inherit the parent event
	event_inherited();

	enum balloon_state {
		IDLE,
		PREPARE,
		FLY_UP,
		STOP_IN_AIR,
		FLOAT,
		FLY_DOWN,
		STOP_AT_GROUND,
		EXIT,
	}


	instance_create_layer(x, y, "instances", objFire);
	instance_create_layer(x, y, "instances", objBrazier);

	fly_speed = 14;

	if (!level_goal){
		state = balloon_state.FLY_DOWN;
		vspeed = fly_speed;
	}
	else state = balloon_state.IDLE;

	keyboard = noone;
	keyboard_offset = 3*pixel_size;

	stop_limit = 3200; 
	ground_stop_limit = objGooseBody.y - 1408;

	depth = objGooseBody.depth + 300;
}