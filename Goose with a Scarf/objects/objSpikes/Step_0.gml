/// @description Insert description here
// You can write your code in this editor

if (place_meeting(x, y, objGooseBody) and (image_angle != 0 or objGooseBody.vspeed >= 0)){	
	objGooseBody.state = player_state.DIE;
}