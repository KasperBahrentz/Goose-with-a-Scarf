if (spawn_timer <= 0 && objGooseBody.state != player_state.GONE){
	if (!check_collision(-image_xscale*8*pixel_size, 0)){
		if (!spawn_one_at_a_time){
			instance_create_layer(x, y, "instances", spawn_object, {roll_dir: -image_xscale});
			spawn_timer = spawn_timer_max;
		}
		else if (!instance_exists(current_roll_object)) {
			current_roll_object = instance_create_layer(x, y, "instances", spawn_object, {roll_dir: -image_xscale});
			spawn_timer = spawn_timer_max;
		}
	}
}
else {
	if (spawn_delay <= 0){
		if (!spawn_one_at_a_time) or (!instance_exists(current_roll_object)){
			spawn_timer--;	
		}
	}
	else spawn_delay--;
}