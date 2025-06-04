image_alpha = 0;
image_speed = 0;

depth = objGooseBody.depth - 2000;

enum keyboard_state {
	APPEAR,
	STAY,
	DISAPPEAR,
	WAIT
}

state = keyboard_state.WAIT;

