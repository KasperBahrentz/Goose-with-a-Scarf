/// @description Insert description here
// You can write your code in this editor

switch(state) {
	case key_state.IDLE:		idle();		break;
	case key_state.FOLLOW:		follow();	break;	
	case key_state.TO_CHEST:	to_chest();	break;
}

function idle(){
	event_inherited();
	if (distance_to_object(objGooseBody) < open_distance) {
		state = key_state.FOLLOW;	
		audio_play_sound(sndKeyCollect, 5, false);
	}
}

function follow(){
	follow_player(0.1, 24);
}

function to_chest(){
	var _lerp_amount = 0.1;
	x = lerp(x, objChest.x, _lerp_amount);
	y = lerp(y, objChest.y-5*pixel_size, _lerp_amount);
	
	if (distance_to_object(objChest) < open_distance){
		with (objChest){
			 state = chest_state.KEY_INSERTED;
	        unlock_timer = 40; // show key for a moment
	        image_index = 1;
		}
		instance_destroy();	
	}
}