/// @description Insert description here
// You can write your code in this editor

enum flower_state {
	BUD,
	PLATFORM	
}

state = flower_state.PLATFORM;

depth += 50;

// Inherit the parent event
event_inherited();

image_index = random_range(0, image_number-1);

timer = random_range(-1, 1);
draw_y = y;

if (leaf_propeller == noone){
	leaf_propeller = instance_create_layer(x, y, "instances", objLeafPropeller);
	if (color == flower_color.BLUE){
		state = flower_state.BUD;	
	}
}
leaf_propeller.flower = self;
leaf_propeller.depth = depth+1;

is_landed_on = false;