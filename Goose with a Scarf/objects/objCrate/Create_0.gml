/// @description Insert description here
// You can write your code in this editor

if (collision_line(x, y, x, y + 12*objGame.pixel_size, prtCrate, false, true)){
	image_index = 1;
}
else if (collision_line(x, y, x - 12*objGame.pixel_size, y, prtCrate, false, true)){
	image_index = 2;	
}