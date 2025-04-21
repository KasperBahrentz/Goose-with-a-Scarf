/// @description Insert description here
// You can write your code in this editor

alarm[0] = 10;

function is_on_water(_tilemap_id){
	// Convert object position to tile coordinates
	var tile_x = tilemap_get_cell_x_at_pixel(_tilemap_id, x, y);
	var tile_y = tilemap_get_cell_y_at_pixel(_tilemap_id, x, y);

	// Get tile data
	var tile_data = tilemap_get(_tilemap_id, tile_x, tile_y);

	// Check if there's a tile (non-zero = tile exists)
	if (tile_data != 0) {
		return true;
	}
	return false;
}
