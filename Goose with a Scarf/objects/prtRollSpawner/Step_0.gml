if (spawn_timer <= 0 && objGooseBody.state != player_state.GONE){
	instance_create_layer(x, y, "instances", spawn_object, {roll_dir: -image_xscale});
	show_debug_message("Spawner id: " + string(self));
	spawn_timer = spawn_timer_max;
}
else {
	if (spawn_delay <= 0) spawn_timer--;	
	else spawn_delay--;
}