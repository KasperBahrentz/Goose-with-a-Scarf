if (smoke_timer <= 0){
	instance_create_layer(smoke_x + irandom_range(-smoke_x_range, smoke_x_range), smoke_y, "instances", objSmoke);	
	smoke_timer = smoke_timer_max + irandom(smoke_timer_max/4);
}
else {
	smoke_timer--;	
}

if (image_index != 2){
	if (objGooseBody.y <= y-16*pixel_size){
		depth = objGooseBody.depth-50;	
	}
	else depth = objGooseBody.depth+50;	
}
else depth = layer_get_depth(layer_get_id("house_back")) + 100;