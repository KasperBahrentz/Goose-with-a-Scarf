/// @description Insert description here
// You can write your code in this editor

check_water_state(objGame.water_front_tilemap);
check_water_state(objGame.water_back_tilemap);
check_wood_state(objGame.deco_tilemap);
check_wood_state(layer_tilemap_get_id("house"));
check_wood_state(layer_tilemap_get_id("house_front"));
check_wood_state(layer_tilemap_get_id("house_back"));

function check_water_state(_tilemap){
	if (is_on_tilemap(_tilemap, y)) and !(is_on_tilemap(_tilemap, y-tile_size)){
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



