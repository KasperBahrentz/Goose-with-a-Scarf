/// @description Insert description here
// You can write your code in this editor

// mute all audio
//audio_set_master_gain(audiogroup_default, 0);

enum fruit_counter {
	PEAR,
	STRAWBERRY,
	GRAPE,
	ORANGE	
}

door_x = 0;
door_y = 0;
exited_house = false;

has_arrived_in_level = false;

found_hidden_blocks = [];

display_set_gui_maximise();
display_set_gui_size(3408*0.75, 1920*0.75);

#macro pixel_size 8
#macro tile_size 128

// IDs of your special triangle tiles — replace these with your actual IDs
top_right_triangle_id = 205;
top_left_triangle_id = 180;

if (!instance_exists(objCam)) instance_create_layer(x, y, "instances", objCam);
window_set_fullscreen(true);

egg_count = 0;
temporary_eggs = [];

base_width = 3408;
base_height = 1920;


draw_set_font(fnt_smooth);

audio_stop_all(); // only for debugging

fruit_collected = [];
number_of_fruit_collected = [0, 0, 0, 0];


