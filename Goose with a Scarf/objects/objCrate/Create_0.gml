/// @description Insert description here
// You can write your code in this editor

if (place_meeting(x, y + 12*pixel_size, prtCrate)){
	image_index = 1;
}
else if (place_meeting(x - 12*pixel_size, y, prtCrate)){
	image_index = 2;	
}