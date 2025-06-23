/// @description Insert description here
// You can write your code in this editor
if (get_tileset_name() == "tlsGroundWinter") check_snow_state(layer_tilemap_get_id("back"));

check_water_state(objGame.water_front_tilemap);
check_water_state(objGame.water_back_tilemap);
check_wood_state(layer_tilemap_get_id("deco"));
check_wood_state(layer_tilemap_get_id("deco_front"));
check_wood_state(layer_tilemap_get_id("deco_middle"));

if (room == room_village){
	check_wood_state(layer_tilemap_get_id("house"));
	check_wood_state(layer_tilemap_get_id("house_front"));
	check_wood_state(layer_tilemap_get_id("house_back"));
}

function check_water_state(_tilemap){
	if (is_on_tilemap(_tilemap, y)) and !(is_on_tilemap(_tilemap, y-tile_size)) or (place_meeting(x, y, objPuddle)){
		image_index = 1;
		material = "water"	
	}
}

function check_wood_state(_tilemap){
	if (is_on_tilemap(_tilemap, y)){
		image_index = 2;
		material = "wood"	
	}
}

function check_snow_state(_tilemap){
	if (is_on_tilemap(_tilemap, y)){
		image_index = 3;
		material = "snow"	
	}
}





