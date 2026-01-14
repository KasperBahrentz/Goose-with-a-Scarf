// This function checks if the instance is colliding with an object, or a tile, at the current
// position + the given movement values (_move_x and _move_y).
// The function returns true if a collision was found, or false if a collision was not found.
	
function check_collision(_move_x, _move_y, _ignore) 
{
    // First, check object collision
	var _hit = instance_place(x + _move_x, y + _move_y, objCollision);
	
	if (_hit != noone)
	{
        var _ignored = false;

        for (var i = 0; i < array_length(_ignore); i++)
        {
            if (_hit.object_index == _ignore[i] || object_is_ancestor(_hit.object_index, _ignore[i]))
            {
                _ignored = true;
                break;
            }
        }

        if (!_ignored)
        {
            return true;
        }
	}

    // Helper function: returns true if point (px, py) is inside the top-left ceiling triangle
	function point_in_triangle_top_left_ceiling(px, py)
	{
	    var _tile_x = floor(px / tile_size) * tile_size;
	    var _tile_y = floor(py / tile_size) * tile_size;
	    var _rel_x = px - _tile_x;
	    var _rel_y = py - _tile_y;

	    return _rel_y <= _rel_x;
	}

	function point_in_triangle_top_right_ceiling(px, py)
	{
	    var _tile_x = floor(px / tile_size) * tile_size;
	    var _tile_y = floor(py / tile_size) * tile_size;
	    var _rel_x = px - _tile_x;
	    var _rel_y = py - _tile_y;

	    return _rel_y <= (tile_size - _rel_x);
	}

    // Function to check collision at a given pixel point with tile ID and triangle checks
    function check_tile_collision(px, py)
    {	
        var tile_id = tilemap_get_at_pixel(objGame.collision_tilemap, px, py);
        if (tile_id == objGame.top_right_triangle_id)
        {
            // Only collide if inside top-left ceiling triangle shape
            return point_in_triangle_top_left_ceiling(px, py);
        }
        else if (tile_id == objGame.top_left_triangle_id)
        {
            // Only collide if inside top-right ceiling triangle shape
            return point_in_triangle_top_right_ceiling(px, py);
        }
        else
        {
            // For all other tiles, no collision
            return tile_id > 0;
        }
    }

    // Now check collision for each corner pixel of bounding box with triangle logic
	var corners = [
	    [bbox_left + _move_x,        bbox_top + _move_y],          // top-left
	    [bbox_right - 1 + _move_x,   bbox_top + _move_y],          // top-right
	    [bbox_right - 1 + _move_x,   bbox_bottom - 1 + _move_y],   // bottom-right
	    [bbox_left + _move_x,        bbox_bottom - 1 + _move_y]    // bottom-left
	];

    // If any corner collides, return true
    for (var i = 0; i < array_length(corners); i++)
    {
        var px = corners[i][0];
        var py = corners[i][1];
        if (check_tile_collision(px, py))
            return true;
    }

    // No collisions found
    return false;
}
