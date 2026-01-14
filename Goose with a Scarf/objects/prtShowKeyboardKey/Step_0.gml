if (active && objGooseBody.is_on_ground && point_distance(x, y, objGooseBody.x, objGooseBody.y) <= activate_range){
	if (keyboard == noone && show_timer <= 0) {
		keyboard = instance_create_layer(x, y, "instances", objKeyW);
	}
	else {
		show_timer--;	
	}
}
else {
	if (keyboard != noone && keyboard.state == keyboard_state.STAY){
		keyboard.state = keyboard_state.DISAPPEAR;	
		keyboard = noone;
	}
	show_timer = show_timer_max;
}