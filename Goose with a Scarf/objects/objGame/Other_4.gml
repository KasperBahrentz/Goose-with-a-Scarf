/// @description Insert description here
// You can write your code in this editor
collision_tilemap = layer_tilemap_get_id("ground");
water_front_tilemap = layer_tilemap_get_id("water_front");
water_back_tilemap = layer_tilemap_get_id("water_back");
deco_tilemap = layer_tilemap_get_id("deco_middle");

var _clouds_front = layer_create(layer_get_depth("mountains_front")-5, "clouds_front");
repeat(random_range(20, 25)) instance_create_layer(random_range(0, room_width), random_range(3*tile_size, room_height-room_height/3), _clouds_front, objCloud);

var _clouds_middle = layer_create(layer_get_depth("mountains_middle")-5, "clouds_middle");
repeat(random_range(20, 25)) instance_create_layer(random_range(0, room_width), random_range(3*tile_size, room_height-room_height/3), _clouds_middle, objCloud);

var _clouds_back = layer_create(layer_get_depth("mountains_back")-5, "clouds_back");
repeat(random_range(20, 25)) instance_create_layer(random_range(0, room_width), random_range(3*tile_size, room_height-room_height/3), _clouds_back, objCloud);

var _clouds_back_back = layer_create(layer_get_depth("mountains_back")+5, "clouds_back_back");
repeat(random_range(20, 25)) instance_create_layer(random_range(0, room_width), random_range(3*tile_size, room_height-room_height/3), _clouds_back_back, objCloud);



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