/// @description Insert description here
// You can write your code in this editor

enum fruit_counter {
	PEAR,
	STRAWBERRY,
	GRAPE,
	ORANGE	
}

display_set_gui_maximise();
display_set_gui_size(3584*0.75, 1904*0.75);

#macro pixel_size 8
#macro tile_size 128

if (!instance_exists(objCam)) instance_create_layer(x, y, "instances", objCam);

egg_count = 0;

temporary_eggs = [];

window_set_fullscreen(true);

draw_set_font(fnt_smooth);

audio_stop_all(); // only for debugging

fruit_collected = [];
number_of_fruit_collected = [0, 0, 0, 0];