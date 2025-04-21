/// @description Insert description here
// You can write your code in this editor
collision_tilemap = layer_tilemap_get_id("ground");
water_front_tilemap = layer_tilemap_get_id("water_front");
water_back_tilemap = layer_tilemap_get_id("water_back");

layer_x("mountains_front", random_range(-2*tile_size, 8*tile_size));
layer_y("mountains_front", random_range(-tile_size, 2*tile_size));

layer_x("mountains_middle", random_range(0, 8*tile_size));
layer_y("mountains_middle", random_range(-2*tile_size, 2*tile_size));

layer_x("mountains_back", random_range(0, 8*tile_size));
layer_y("mountains_back", random_range(-2*tile_size, 2*tile_size));


// Colour temprary eggs
for (var i = 0; i < instance_number(objNest); i++){
	var _inst = instance_find(objNest, i);
	var _index = (2*i);
	_inst.temporary_index = _index;
	_inst.alarm[0] = 1;
}