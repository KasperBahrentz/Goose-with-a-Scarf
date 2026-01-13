if (active && objGooseBody.is_on_ground && distance_to_object(objGooseBody) <= activate_range){
	if (keyboard == noone) {
		keyboard = instance_create_layer(x, y, "instances", objKeyW);
	}
}
else {
	if (keyboard != noone && keyboard.state == keyboard_state.STAY){
		keyboard.state = keyboard_state.DISAPPEAR;	
		keyboard = noone;
	}
}