// Inherit the parent event
event_inherited();

if (distance_to_object(objGooseBody) <= activate_range)	active = false;

enum door_state {
	CLOSED,
	OPEN
}

state = door_state.CLOSED;

image_speed = 0;
