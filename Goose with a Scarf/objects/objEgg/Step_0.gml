switch (state){
	case egg_state.MOVE: move(); break;
	case egg_state.IDLE: idle(); break;
}


function move(){
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

function idle(){
	// Ensure there's data in the queue
	if (array_length(my_queue) > 6*egg_id){
		state = egg_state.MOVE;
	}
}