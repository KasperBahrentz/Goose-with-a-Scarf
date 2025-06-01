enum turkey_state {
	WALK_LEFT,
	WALK_RIGHT,
	WAIT,
}

state = turkey_state.WALK_LEFT;
next_state = state;

wait_timer = 180;

walking_range = 4*tile_size;

walking_speed_start = 3;
walking_speed = walking_speed_start;