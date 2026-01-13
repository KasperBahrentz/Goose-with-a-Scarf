if (smoke_timer <= 0){
	instance_create_depth(x + irandom_range(-smoke_x_range, smoke_x_range), smoke_y, depth, objSmoke);	
	smoke_timer = smoke_timer_max + irandom(smoke_timer_max/4);
}
else if (makes_smoke) {
	smoke_timer--;	
}

if (image_index != 2){
	if (objGooseBody.y <= y-16*pixel_size){
		depth = objGooseBody.depth-50;	
	}
	else depth = objGooseBody.depth+50;	
}
else depth = objGooseBody.depth + 50;