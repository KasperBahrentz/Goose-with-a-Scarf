/// @description Insert description here
// You can write your code in this editor

dark_grey = make_colour_rgb(55, 65, 90);
grey = make_colour_rgb(85, 100, 125);
light_grey = make_colour_rgb(120, 145, 165);

change_to_grey = irandom_range(image_number/6, image_number/2);
change_to_light_grey = irandom_range(change_to_grey, image_number/1.1);

image_blend = dark_grey;

image_speed = irandom_range(8, 11);

if (smoke_in_back){
	depth = objGooseBody.depth + 5;
}
else depth = objChimney.depth - 5;
depth_start = depth;

direction = random_range(90, 100);
image_index = random_range(0, 3);
image_xscale = choose(1, -1);
image_yscale = choose(1, -1);
speed = random_range(2, 3);

last_image_index = image_index;