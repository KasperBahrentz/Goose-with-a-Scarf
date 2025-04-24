/// @description Insert description here
// You can write your code in this editor

check_water_state(objGame.water_front_tilemap);
check_water_state(objGame.water_back_tilemap);

function check_water_state(_tilemap){
	if (is_on_water(_tilemap, y)) and !(is_on_water(_tilemap, y-tile_size)){
		image_index = 1;
		material = "water"	
	}
}


