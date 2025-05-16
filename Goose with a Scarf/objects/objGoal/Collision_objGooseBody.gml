/// @description Insert description here
// You can write your code in this editor

if (objGooseBody.state == player_state.MOVE){
	objGooseBody.state = player_state.GONE;
	alarm[0] = 160;
	instance_create_layer(x, y, "instances", objDarkCircle, {alpha_speed : 0.025});
	instance_destroy(objGoalTop);
	audio_play_sound(sndGoal, 12, false);
	image_index = 1;
}	
