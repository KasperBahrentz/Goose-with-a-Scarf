switch (state){
	case egg_state.MOVE: move(); break;
}


function move(){
	var _index = 1 + array_find_index(objGooseBody.egg_queue, function(_element, _index){
	    return (_element == egg_id);
	}, -1, -infinity);
	
	if (array_length(my_queue) > 6*_index){
	
		// Get the oldest stored position
		var _pos = array_pop(my_queue);
		var _target_x = _pos[0];
		var _target_y = _pos[1];

		// Calculate distance to the player
		var _dist_x = abs(objGooseBody.x - x);	
		var _dist_y = abs(objGooseBody.y - y);	

		// Move
		x = lerp(x, _target_x, 0.5);
		y = lerp(y, _target_y, 0.5);
	}
}