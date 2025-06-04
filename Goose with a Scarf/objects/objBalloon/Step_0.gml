// Inherit the parent event
event_inherited();

depth = objDodo.depth + 20;

if (point_distance(x, ystart, objGooseBody.x, objGooseBody.y) <= 20*pixel_size and objGooseBody.is_on_ground){
	if (keyboard == noone) {
		keyboard = instance_create_layer(x, y, "instances", objKeyW);
	}
	else {
		//keyboard.y = y - keyboard_offset;
	}
}
else if (keyboard != noone){
	keyboard.state = keyboard_state.DISAPPEAR;
	keyboard = noone;
}
