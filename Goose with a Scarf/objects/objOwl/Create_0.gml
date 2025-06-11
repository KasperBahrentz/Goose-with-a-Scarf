/// @desc
enum owl_state {
	WAIT,
	BLINK,
	SLEEP,
	EXIT_SLEEP,
}

state = owl_state.WAIT;

blink_timer = irandom_range(120, 240);
last_blink_timer = blink_timer;
first_blink_timer = blink_timer;
blink_counter = choose(1, 2);
last_image_index = 0;

change_to_blink = false;

image_speed = 0.2;
z_timer_max = 60;
z_timer = z_timer_max;