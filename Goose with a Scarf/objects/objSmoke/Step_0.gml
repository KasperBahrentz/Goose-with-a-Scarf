/// @description Insert description here
// You can write your code in this editor

var _nearest_chimney = instance_nearest(x, y, objChimney);
depth = _nearest_chimney.depth - 5;

if (image_blend == dark_grey and image_index >= change_to_grey){
	image_blend = grey;	
	speed *= random_range(0.85, 0.95);
	image_xscale = choose(1, -1);
	image_yscale = choose(1, -1);
}
else if (image_blend == grey and image_index >= change_to_light_grey){
	image_blend = light_grey;	
	speed *= random_range(0.7, 0.85);
	image_xscale = choose(1, -1);
	image_yscale = choose(1, -1);
}

if (floor(image_index) != floor(last_image_index)){
	if (direction <= 160) direction += random_range(2, 4);
	last_image_index = image_index;
}

if (image_index >= image_number-1){
	instance_destroy();
}