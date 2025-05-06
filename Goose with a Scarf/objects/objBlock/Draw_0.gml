/// @description Insert description here
// You can write your code in this editor

var _nearest_block = collision_rectangle(x-10*pixel_size, y-10*pixel_size, x+10*pixel_size, y+10*pixel_size, objBlock, false, true);
if (_nearest_block != noone){
	draw_set_alpha(image_alpha);
	draw_line_width(x, y, _nearest_block.x, _nearest_block.y, pixel_size); 
	draw_set_alpha(1);
}
