/// @description Insert description here
// You can write your code in this editor

#macro pixel_size 8
#macro tile_size 128

if (!instance_exists(objCam)) instance_create_layer(x, y, "instances", objCam);

egg_count = 0;

temporary_eggs = [];

window_set_fullscreen(true);

draw_set_font(fnt_16_bit);