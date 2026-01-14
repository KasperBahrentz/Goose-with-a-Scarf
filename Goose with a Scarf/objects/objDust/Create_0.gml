/// @description Insert description here
// You can write your code in this editor

var tilemap_id = layer_tilemap_get_id("ground");
var tileset_id = tilemap_get_tileset(tilemap_id);
var tileset_name = tileset_get_name(tileset_id);

is_snow = false;

if (tileset_name == "tlsGroundWinterNight"){
	is_snow = true;
}

image_index = random_range(0, 2);
image_xscale = choose(1, -1);
image_yscale = choose(1, -1);
speed = random_range(4, 8);

if (is_snow){
	sprite_index = sprDustSnow;	
	speed = random_range(2, 4);
}

depth -= 10;

switch(dust_id){	
	case "down":	direction = random_range(225, 315);		speed = random_range(2, 4);		break;
	case "left":	direction = random_range(145, 225);										break;
	case "right":	direction = random_range(315, 360+35);									break;
}
