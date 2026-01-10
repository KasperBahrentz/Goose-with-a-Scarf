// Inherit the parent event

switch(state){
	case balloon_state.IDLE:			idle();				break;
	case balloon_state.PREPARE:			prepare();			break;
	case balloon_state.FLY_UP:			fly_up();			break;
	case balloon_state.STOP_IN_AIR:		stop_in_air();		break;
	case balloon_state.FLOAT:			float();			break;
	case balloon_state.FLY_DOWN:		fly_down();			break;
	case balloon_state.STOP_AT_GROUND:	stop_at_ground();	break;
	case balloon_state.EXIT:			exit_balloon();		break;
}

function idle(){
	event_inherited();
	display_key();
}

function prepare(){
	if (image_index == 0) image_index = 1;
	else if (image_index == 3) image_index = 2;
	event_inherited();
	
	if (keyboard_check_pressed(ord("W"))){
		state = balloon_state.FLY_UP;
		if (level_goal) alarm[1] = 60;
		instance_destroy(objDodo);
		audio_play_sound(sndFireStart, 10, false);
	}
	
	check_for_exit_balloon();
}

function fly_up(){
	if (!audio_is_playing(sndGasFlame)) audio_play_sound(sndGasFlame, 3, true);
	if (room == room_village and !audio_is_playing(sndPiano)) audio_play_sound(sndPiano, 10, false);
	if (image_index == 1){
		image_index = 2;
	}
	if (room != room_level_spring_1 && room != room_level_summer_1) objCam.follow = objBalloon;
	else { // if leaving regular level
		if (speech_bubble == noone){
			if (alarm[2] = -1) alarm[2] = 60;
		}
		else speech_bubble.y = y-16*pixel_size;
	}
	vspeed = lerp(vspeed, -fly_speed, 0.01);
	if (room == room_village and y <= stop_limit){
		state = balloon_state.STOP_IN_AIR;	
	}
	else if (image_index = 2 and y <5*tile_size){
		if (alarm[0] <= 0) alarm[0] = 160;
		if (!instance_exists(objDarkSquare)) instance_create_layer(x, y, "instances", objDarkSquare, {from_top : false});
	}
}

function stop_in_air(){
	vspeed = lerp(vspeed, 0, 0.01);
	pan_camera = true;
	
	if (abs(vspeed) < 1){
		audio_sound_gain(sndGasFlame, 0, 120);
		vspeed = 0;
		state = balloon_state.FLOAT;
		timer = -1;
	}
}


function float(){
	event_inherited();
}


function display_key(){
	if (point_distance(x, y, objGooseBody.x, objGooseBody.y) <= 20*pixel_size and objGooseBody.is_on_ground){
		if (keyboard == noone) {
			keyboard = instance_create_layer(x, y, "instances", objKeyW);
		}
		
		if (keyboard_check_pressed(ord("W"))){
			state = balloon_state.PREPARE;
			objGooseBody.state = player_state.GONE;
			keyboard.state = keyboard_state.DISAPPEAR;
			keyboard = noone;
		}
	}
	else if (keyboard != noone){
		keyboard.state = keyboard_state.DISAPPEAR;
		keyboard = noone;
	}	
}

function fly_down(){
	objGooseBody.state = player_state.GONE;
	
	if (objCam.follow != objBalloon){
		instance_create_layer(x, y, "instances", objDarkSquare, {from_top : true});
		objCam.x = x;
		objCam.y = y;	
		objCam.follow = objBalloon;	
	}
	
	
	image_index = 2;
	vspeed = lerp(vspeed, fly_speed, 0.01);
	if (!level_goal and y >= ground_stop_limit){
		state = balloon_state.STOP_AT_GROUND;	
	}
}

function stop_at_ground(){
	vspeed = lerp(vspeed, 0, 0.01);
		
	if (abs(vspeed) < 1){
		vspeed = 0;
		state = balloon_state.EXIT;
		timer = 1;
	}
}

function exit_balloon(){
	event_inherited();
	if (!instance_exists(objKeyWASD)) instance_create_layer(x, y + 32*pixel_size, "instances", objKeyWASD);
	check_for_exit_balloon();
}

function check_for_exit_balloon() {
	if (image_index == 1 or image_index == 2) and (keyboard_check(ord("A")) or keyboard_check(ord("D"))){
		if (room == room_village or level_goal) state = balloon_state.IDLE;
		else state = balloon_state.FLY_UP;
		objGooseBody.state = player_state.MOVE;
		if (image_index == 1) image_index = 0;
		else if (image_index == 2) image_index = 3;
		objCam.follow = objGooseBody;
		if (instance_exists(objKeyWASD)) objKeyWASD.state = keyboard_state.DISAPPEAR;
		objGame.has_arrived_in_level = true;
	}
}



objBrazier.y = y;
objFire.y = y-21*pixel_size;