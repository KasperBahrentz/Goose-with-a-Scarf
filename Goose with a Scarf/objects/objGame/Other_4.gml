/// @description Insert description here
// You can write your code in this editor
collision_tilemap = layer_tilemap_get_id("ground");
water_front_tilemap = layer_tilemap_get_id("water_front");
water_back_tilemap = layer_tilemap_get_id("water_back");
deco_tilemap = layer_tilemap_get_id("deco_middle");
back_tilemap = layer_tilemap_get_id("back");

// Colour temprary eggs
for (var i = 0; i < instance_number(objNest); i++){
	var _inst = instance_find(objNest, i);
	var _index = (2*i);
	_inst.temporary_index = _index;
	_inst.alarm[0] = 1;
}