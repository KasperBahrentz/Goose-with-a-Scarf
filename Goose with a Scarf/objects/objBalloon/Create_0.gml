// Inherit the parent event
event_inherited();

enum balloon_state {
	IDLE,
	PREPARE,
	FLY_UP,
	STOP_IN_AIR,
	FLOAT	
}


instance_create_layer(x, y, "instances", objFire);
instance_create_layer(x, y, "instances", objBrazier);

state = balloon_state.IDLE;

keyboard = noone;
keyboard_offset = 3*pixel_size;

fly_speed = 14;

stop_limit = 3200;

depth = objGooseBody.depth + 300;