// Inherit the parent event
event_inherited();

switch(state){
	case door_state.CLOSED:	closed();	break;
	case door_state.OPEN:	open();		break;
}

function closed(){
	if (distance_to_object(objGooseBody) <= activate_range){
		if (keyboard_check_pressed(ord("W"))){
			audio_play_sound(sndDoor, 20, false);
			state = door_state.OPEN
			
			if (objCam.in_house){
				objGame.exited_house = true;	
			}
			else {
				objGame.door_x = x;
				objGame.door_y = y;	
			}
			
		}
	}
	else {
		active = true;
	}
}

function open(){
	image_speed = 1;
	if (image_index >= image_number-1){
		image_speed = 0;
		room_goto(target_room);
	}
}