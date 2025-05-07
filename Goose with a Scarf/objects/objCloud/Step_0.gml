/// @description Insert description here
// You can write your code in this editor

// Respawn cloud
if (x < -sprite_width){
	x = room_width + sprite_width + irandom(tile_size);	// Add a bit of randomness
	y += random_range(-tile_size, tile_size)
}