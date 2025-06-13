switch(state){
	case hidden_detector_state.OFF:		off();		break;
	case hidden_detector_state.CHECK:	check();	break;
	case hidden_detector_state.ON:		on();		break;
}

function off(){
	if (place_meeting(x, y, objGooseBody)){
		state = hidden_detector_state.CHECK;
	}
}

function check(){
	audio_sound_pitch(sndWooshHidden, random_range(0.9, 1.1));
	if (array_length(objGame.found_hidden_blocks) <= 0) audio_play_sound(sndWooshHidden, 50, false);
	
	var _none_detected = true;
	var _master_exists = false;
	
	for (var i = 0; i < instance_number(objHiddenDetection); i++){
		var _instance = instance_find(objHiddenDetection, i);
		if (_instance.master == true) _master_exists = true;
		if (_instance.state == hidden_detector_state.OFF and place_meeting(x, y, _instance)){
			_instance.state = hidden_detector_state.CHECK;
			_none_detected = false;
		}
	}
	
	if (_none_detected and !_master_exists){
		master = true;
	}
	
	// Check if block is colliding with any hidden blocks
	for (var i = 0; i < array_length(objGame.hidden_assets); i++){
		var _hidden_block_id = objGame.hidden_assets[i];
		var _x = layer_sprite_get_x(_hidden_block_id);
		var _y = layer_sprite_get_y(_hidden_block_id);

		if (collision_rectangle(_x, _y, _x+128, _y+128, self, false, false) and !(array_contains(objGame.found_hidden_blocks, _hidden_block_id))){ // Check for collision with block
			array_push(objGame.found_hidden_blocks, _hidden_block_id);
		} 
	}
	
	state = hidden_detector_state.ON;
}

function on(){
	image_blend = c_red;
	if (master){
		image_blend = c_yellow;
		// Remove hidden blocks
		for (var i = 0; i < array_length(objGame.found_hidden_blocks); i++){
			var _hidden_block_id = objGame.found_hidden_blocks[i];
			var _current_alpha = layer_sprite_get_alpha(_hidden_block_id);
			if (_current_alpha <= 0){
				array_delete(objGame.found_hidden_blocks, array_get_index(objGame.found_hidden_blocks, objGame.found_hidden_blocks), 1);
			}
			else {
				layer_sprite_alpha(_hidden_block_id, lerp(_current_alpha, 0, 0.15));
			}
		}
	}
	if (array_length(objGame.found_hidden_blocks) <= 0) instance_destroy();
}