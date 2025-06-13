image_speed = 0;

smoke_y = y-22*pixel_size;
smoke_x_range = 3*pixel_size;

if (image_index == 1){
	smoke_y = y-18*pixel_size;
	smoke_x_range = 4*pixel_size;	
}
else if (image_index == 2){
	smoke_y = y-4*pixel_size;
}

smoke_timer_max = 4;
smoke_timer = 0;