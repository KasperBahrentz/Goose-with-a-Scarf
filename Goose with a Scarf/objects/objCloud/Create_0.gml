/// @description Insert description here
// You can write your code in this editor

var tilemap_id = layer_tilemap_get_id("ground");
var tileset_id = tilemap_get_tileset(tilemap_id);
var tileset_name = tileset_get_name(tileset_id);
show_debug_message("Tileset: " + tileset_name);

// Destroy cloud if too close to other clouds at spawn
if (collision_circle(x, y, 32*pixel_size, objCloud, false, true)) instance_destroy();

if (tileset_name == "tlsGroundWinter"){
	sprite_index = sprCloudWinterFront;	
}

state = "front";
x_start = x;
parallax_factor = 16;

if (layer == layer_get_id("clouds_front")){
	image_alpha = random_range(0.8, 0.9);
}
else if (layer == layer_get_id("clouds_middle")){
	image_alpha = random_range(0.7, 0.8);
	state = "middle";
	parallax_factor = 24;
	sprite_index = sprCloudMiddle;
	if (tileset_name == "tlsGroundWinter"){
		sprite_index = sprCloudWinterMiddle;	
	}
}
else if (layer == layer_get_id("clouds_back")){
	image_alpha = random_range(0.6, 0.7);
	state = "back";
	parallax_factor = 48;
	sprite_index = sprCloudBack;
	if (tileset_name == "tlsGroundWinter"){
		sprite_index = sprCloudWinterBack;	
	}
}
else if (layer == layer_get_id("clouds_back")){
	image_alpha = random_range(0.5, 0.6);
	state = "back_back";
	parallax_factor = 64;
	sprite_index = sprCloudBack;
	if (tileset_name == "tlsGroundWinter"){
		sprite_index = sprCloudWinterBack;	
	}
}


image_index = irandom_range(0, image_number-1);
speed = -random_range(10, 20) / parallax_factor;