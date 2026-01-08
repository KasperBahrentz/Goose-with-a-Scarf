/// @description Insert description here
// You can write your code in this editor

audio_set_master_gain(audiogroup_default, 0);

enum fruit_counter {
	PEAR,
	STRAWBERRY,
	GRAPE,
	ORANGE	
}

has_arrived_in_level = false;

found_hidden_blocks = [];

display_set_gui_maximise();
display_set_gui_size(3584*0.75, 1904*0.75);

#macro pixel_size 8
#macro tile_size 128

// IDs of your special triangle tiles — replace these with your actual IDs
#macro top_right_triangle_id 205
#macro top_left_triangle_id 180

if (!instance_exists(objCam)) instance_create_layer(x, y, "instances", objCam);

egg_count = 0;

temporary_eggs = [];

window_set_fullscreen(true);

draw_set_font(fnt_smooth);

audio_stop_all(); // only for debugging

fruit_collected = [];
number_of_fruit_collected = [0, 0, 0, 0];


