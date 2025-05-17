var _clouds_front = layer_create(layer_get_depth("mountains_front")-5, "clouds_front");
repeat(random_range(20, 25)) instance_create_layer(random_range(0, room_width), random_range(3*tile_size, room_height-room_height/3), _clouds_front, objCloud);

var _clouds_middle = layer_create(layer_get_depth("mountains_middle")-5, "clouds_middle");
repeat(random_range(20, 25)) instance_create_layer(random_range(0, room_width), random_range(3*tile_size, room_height-room_height/3), _clouds_middle, objCloud);

var _clouds_back = layer_create(layer_get_depth("mountains_back")-5, "clouds_back");
repeat(random_range(20, 25)) instance_create_layer(random_range(0, room_width), random_range(3*tile_size, room_height-room_height/3), _clouds_back, objCloud);

var _clouds_back_back = layer_create(layer_get_depth("mountains_back")+5, "clouds_back_back");
repeat(random_range(20, 25)) instance_create_layer(random_range(0, room_width), random_range(3*tile_size, room_height-room_height/3), _clouds_back_back, objCloud);


layer_x("mountains_front", random_range(-2*tile_size, 8*tile_size));
layer_y("mountains_front", layer_get_y("mountains_front") + random_range(-3*tile_size, 2*tile_size));

layer_x("mountains_middle", random_range(-2*tile_size, 8*tile_size));
layer_y("mountains_middle", layer_get_y("mountains_front") + random_range(-2*tile_size, 2*tile_size));

layer_x("mountains_back", random_range(-2*tile_size, 8*tile_size));
layer_y("mountains_back", layer_get_y("mountains_front") + random_range(-1*tile_size, 2*tile_size));

mountains_front_x = layer_get_x("mountains_front");
mountains_front_y = layer_get_y("mountains_front");

mountains_middle_x = layer_get_x("mountains_middle");
mountains_middle_y = layer_get_y("mountains_middle");

mountains_back_x = layer_get_x("mountains_back");
mountains_back_y = layer_get_y("mountains_back");