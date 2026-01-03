if (spawn_timer <= 0){
	instance_create_layer(x, y, "instances", objMelon, {roll_dir: -image_xscale});
	spawn_timer = spawn_timer_max + random_range(0, spawn_timer_max);
}
else {
	spawn_timer--;	
}