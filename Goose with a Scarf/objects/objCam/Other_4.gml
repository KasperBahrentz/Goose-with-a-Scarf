// Helper function to get a random number divisible by 8 in a given range
function random_div8_range(min_val, max_val) {
    var min_multiple = ceil(min_val / 8);
    var max_multiple = floor(max_val / 8);
    return random_range(min_multiple, max_multiple) * 8;
}

var _clouds_front = layer_create(layer_get_depth("mountains_front")-5, "clouds_front");
repeat(random_range(20, 25)) instance_create_layer(random_div8_range(0, room_width), random_div8_range(3*tile_size, room_height-room_height/3), _clouds_front, objCloud);

var _clouds_middle = layer_create(layer_get_depth("mountains_middle")-5, "clouds_middle");
repeat(random_range(20, 25)) instance_create_layer(random_div8_range(0, room_width), random_div8_range(3*tile_size, room_height-room_height/3), _clouds_middle, objCloud);

var _clouds_back = layer_create(layer_get_depth("mountains_back")-5, "clouds_back");
repeat(random_range(20, 25)) instance_create_layer(random_div8_range(0, room_width), random_div8_range(3*tile_size, room_height-room_height/3), _clouds_back, objCloud);

var _clouds_back_back = layer_create(layer_get_depth("mountains_back")+5, "clouds_back_back");
repeat(random_range(20, 25)) instance_create_layer(random_div8_range(0, room_width), random_div8_range(3*tile_size, room_height-room_height/3), _clouds_back_back, objCloud);

if (get_tileset_name() == "tlsGroundWinter"){
	var _stars = layer_create(layer_get_depth(_clouds_back_back)+5, "stars");
	repeat(random_range(40, 50)) instance_create_layer(random_div8_range(tile_size, room_width-tile_size), random_div8_range(2*tile_size, room_height-room_height/2), _stars, objStar);
	//instance_create_layer(random_div8_range(0, room_width), random_div8_range(2*tile_size, room_height-room_height/3), _stars, objMoon);
}
else {
	// Mountains front
	layer_x("mountains_front", random_div8_range(-2 * tile_size, 480*pixel_size));
	layer_y("mountains_front", layer_get_y("mountains_front") + random_div8_range(-3 * tile_size, 0));

	// Mountains middle
	layer_x("mountains_middle", random_div8_range(0, 480*pixel_size));
	layer_y("mountains_middle", layer_get_y("mountains_front") + random_div8_range(-2 * tile_size, 0));

	// Mountains back
	layer_x("mountains_back", random_div8_range(-2 * tile_size, 8 * 480*pixel_size));
	layer_y("mountains_back", layer_get_y("mountains_front") + random_div8_range(-1 * tile_size, 0));	
	
}

show_debug_message("-------------------------")
show_debug_message("Mountains front x: ");
show_debug_message(floor(layer_get_x("mountains_front")));
show_debug_message("Mountains front y: ");
show_debug_message(floor(layer_get_y("mountains_front")));
show_debug_message("Mountains middle x: ");
show_debug_message(floor(layer_get_x("mountains_middle")));
show_debug_message("Mountains middle y: ");
show_debug_message(floor(layer_get_y("mountains_middle")));
show_debug_message("Mountains back x: ");
show_debug_message(floor(layer_get_x("mountains_back")));
show_debug_message("Mountains back y: ");
show_debug_message(floor(layer_get_y("mountains_back")));


mountains_front_x = layer_get_x("mountains_front");
mountains_front_y = layer_get_y("mountains_front");

mountains_middle_x = layer_get_x("mountains_middle");
mountains_middle_y = layer_get_y("mountains_middle");

mountains_back_x = layer_get_x("mountains_back");
mountains_back_y = layer_get_y("mountains_back");