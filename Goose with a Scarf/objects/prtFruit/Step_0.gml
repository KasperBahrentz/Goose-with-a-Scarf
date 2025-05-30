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
	follow_player(0.1, 16);
	
	if (objGooseBody.is_on_ground && objGooseBody.state == player_state.MOVE) or (objGoal.goal_touched == true){
		state = fruit_state.COLLECT;
		audio_play_sound(sndPling, 15, false);
		image_speed = img_speed;
		objGame.number_of_fruit_collected[fruit_index]++;
		instance_create_layer(-100, -100, "instances", objFruitCollectedGUI, {fruit : self.object_index});
	}
}

function collect(){
	if (image_index >= image_number-2){
		array_insert(objGame.fruit_collected, -1, room_get_name(room));
		instance_destroy();	
	}	
}