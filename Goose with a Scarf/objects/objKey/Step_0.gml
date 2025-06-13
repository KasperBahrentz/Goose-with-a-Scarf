/// @description Insert description here
// You can write your code in this editor

switch(state) {
	case key_state.IDLE:		idle();			break;
	case key_state.FOLLOW:		follow();		break;	
	case key_state.TO_TARGET:	to_target();	break;
}

function idle(){
	event_inherited();
	if (distance_to_object(objGooseBody) < collect_distance) {
		state = key_state.FOLLOW;	
		audio_play_sound(sndKeyCollect, 5, false);
		
		// How high above the player should the key float
		with (objKey) {
			if (state == key_state.FOLLOW) {
				array_insert(objGooseBody.keys, 0, id);
			}
		}
	}
}

function follow(){
	var _index = array_get_index(objGooseBody.keys, id);
	follow_player(0.1, 24+10*_index, 1-(_index / array_length(objGooseBody.keys)));
}

function to_target(){
	var _lerp_amount = 0.2;
	
	var _middle_x = target_instance.x + floor(target_instance.sprite_width/2);
	var _middle_y = target_instance.y + floor(target_instance.sprite_height/2);
	
	x = lerp(x, _middle_x, _lerp_amount);
	y = lerp(y, _middle_y, _lerp_amount);
	
	if (distance_to_object(target) < 1*pixel_size){
		if (!audio_is_playing(sndUnlock)) audio_play_sound(sndUnlock, 30, false);
		target_instance.state = locked_state.KEY_INSERTED;
	    target_instance.unlock_timer = 40; // show key for a moment
	    target_instance.image_index = 1;
		instance_destroy();	
		array_shift(objGooseBody.keys);
	}
}