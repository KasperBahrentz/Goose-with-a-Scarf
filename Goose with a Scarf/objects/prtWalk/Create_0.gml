enum walk_state {
	WALK_LEFT,
	WALK_RIGHT,
	WAIT,
	EXIT_WAIT
}

state = choose(walk_state.WALK_LEFT, walk_state.WALK_RIGHT);
next_state = state;

walking_speed = walking_speed_start;