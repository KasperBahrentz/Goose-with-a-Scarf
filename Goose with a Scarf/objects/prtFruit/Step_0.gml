/// @description Insert description here
// You can write your code in this editor

switch(state){
	case fruit_state.ITEM:		item();		break;
	case fruit_state.FOLLOW:	follow();	break;	
	case fruit_state.COLLECT:	collect();	break;
}

function item(){
	event_inherited();		
	if (place_meeting(x, y, objGooseBody)) or (place_meeting(x, y, objEgg)){
		audio_sound_pitch(sndBlub, random_range(0.8, 0.9));
		audio_play_sound(sndBlub, 5, false); 
		image_index++;
		y -= 4*pixel_size;
		state = fruit_state.FOLLOW;
	}
}

function follow(){
	var _lerp_amount = 0.1;
	
	x = lerp(x, objGooseBody.x, _lerp_amount);
	y = lerp(y, objGooseBody.y-16*pixel_size, _lerp_amount);
		
	if (objGooseBody.state == player_state.DIE){
		instance_destroy();	
	}
		
	if (objGooseBody.vspeed == 0 && objGooseBody.state == player_state.MOVE){
		state = fruit_state.COLLECT;
		audio_play_sound(sndPling, 15, false);
		image_speed = img_speed;
		objGame.fruit_collected[fruit_index]++;
		instance_create_layer(-100, -100, "instances", objFruitCollectedGUI, {fruit : self.object_index});
	}
}

function collect(){
	if (image_index >= image_number-2){
		instance_destroy();	
	}	
}