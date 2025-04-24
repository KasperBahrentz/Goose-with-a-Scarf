/// @description Insert description here
// You can write your code in this editor

// Destroy cloud if too close to other clouds at spawn
if (collision_circle(x, y, 32*pixel_size, objCloud, false, true)) instance_destroy();


state = "front";
x_start = x;
parallax_factor = 8;

if (layer == layer_get_id("clouds_front")){
	image_alpha = random_range(0.8, 0.9);
}
else if (layer == layer_get_id("clouds_middle")){
	image_alpha = random_range(0.7, 0.8);
	state = "middle";
	parallax_factor = 16;
}
else if (layer == layer_get_id("clouds_back")){
	image_alpha = random_range(0.6, 0.7);
	state = "back";
	parallax_factor = 32;
}
else if (layer == layer_get_id("clouds_back")){
	image_alpha = random_range(0.5, 0.6);
	state = "back_back";
	parallax_factor = 64;
}


image_index = random_range(0, image_number-1);
speed = -random_range(10, 20) / parallax_factor;