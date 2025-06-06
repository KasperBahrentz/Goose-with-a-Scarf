// Inherit the parent event
event_inherited();

enum balloon_state {
	IDLE,
	PREPARE,
	FLY_UP,
	STOP_IN_AIR,
	FLOAT	
}

state = balloon_state.IDLE;

keyboard = noone;
keyboard_offset = 4*pixel_size;

fly_speed = 14;

stop_limit = 2700;