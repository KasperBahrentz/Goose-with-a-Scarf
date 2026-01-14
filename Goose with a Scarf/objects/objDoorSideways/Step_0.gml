switch(state){
	case door_sideways_state.LOCKED:	locked();	break;
	case door_sideways_state.CLOSED:	closed();	break;
	case door_sideways_state.OPEN:		open();		break;
}

function locked(){
	if (collision_blocks == noone){
		var _x_offset = 8*pixel_size;
		var _facing_right = image_index == 4;
		var _x = _facing_right ? x - tile_size + _x_offset : x - _x_offset;
		collision_blocks = [instance_create_layer(_x, y - tile_size, "collision", objCollision), instance_create_layer(_x, y - 2*tile_size, "collision", objCollision)];	
	}
}

function closed(){
	image_index = 0;
	if (point_distance(x, y, objGooseBody.x, objGooseBody.y) <= open_distance){
		var _goose_on_left = objGooseBody.x < x;
		state = door_sideways_state.OPEN;
		audio_play_sound(sndDoor, 15, false);
		if (_goose_on_left){
			image_index = 1;
		}
		else {
			image_index = 2;	
		}
	}
}

function open(){
	if (point_distance(x, y, objGooseBody.x, objGooseBody.y) <= close_distance){
		auto_close_timer = auto_close_timer_max;
	}
	else {
		if (auto_close_timer <= 0){
			audio_play_sound(sndDoor, 15, false);
			state = door_sideways_state.CLOSED;	
		}
		auto_close_timer--;	
	}
}