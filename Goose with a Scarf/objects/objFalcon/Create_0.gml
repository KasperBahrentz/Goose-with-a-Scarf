// Inherit the parent event
event_inherited();

enum falcon_state {
	LOOK_RIGHT,
	LOOK_STRAIGHT,
	LOOK_RIGHT_AGAIN
}

state = falcon_state.LOOK_RIGHT;

look_right_time = 120;
look_straight_time = 120;

img_spd = image_speed;

depth = objGooseBody.depth -100;