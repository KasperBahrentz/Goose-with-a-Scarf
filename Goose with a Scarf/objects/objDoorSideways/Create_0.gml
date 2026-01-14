enum door_sideways_state {
	LOCKED,
	CLOSED,
	OPEN
}

state = door_sideways_state.CLOSED;

if (image_index == 3 || image_index == 4) state = door_sideways_state.LOCKED;

collision_blocks = noone;

open_distance = 32;
close_distance = 128;
image_speed = 0;

auto_close_timer_max = 30;
auto_close_timer = auto_close_timer_max;