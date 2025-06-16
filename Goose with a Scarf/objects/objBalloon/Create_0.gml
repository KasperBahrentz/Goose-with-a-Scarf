// Inherit the parent event
event_inherited();

enum balloon_state {
	IDLE,
	PREPARE,
	FLY_UP,
	STOP_IN_AIR,
	FLOAT,
	FLY_DOWN,
}


instance_create_layer(x, y, "instances", objFire);
instance_create_layer(x, y, "instances", objBrazier);

if (!level_goal) state = balloon_state.FLY_DOWN;
else state = balloon_state.IDLE;

keyboard = noone;
keyboard_offset = 3*pixel_size;

fly_speed = 14;

stop_limit = 3200;

depth = objGooseBody.depth + 300;