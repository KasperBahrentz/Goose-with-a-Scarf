/// @description Insert description here
// You can write your code in this editor
collision_tilemap = layer_tilemap_get_id("ground");

layer_x("mountains_front", random_range(-2*objGame.tile_size, 8*objGame.tile_size));
layer_y("mountains_front", random_range(-objGame.tile_size, 2*objGame.tile_size));

layer_x("mountains_middle", random_range(0, 8*objGame.tile_size));
layer_y("mountains_middle", random_range(-2*objGame.tile_size, 2*objGame.tile_size));

layer_x("mountains_back", random_range(0, 8*objGame.tile_size));
layer_y("mountains_back", random_range(-2*objGame.tile_size, 2*objGame.tile_size));
