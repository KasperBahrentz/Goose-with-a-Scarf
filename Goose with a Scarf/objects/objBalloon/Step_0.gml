// Inherit the parent event

switch(state){
	case balloon_state.IDLE:			idle();				break;
	case balloon_state.PREPARE:			prepare();			break;
	case balloon_state.FLY_UP:			fly_up();			break;
	case balloon_state.STOP_IN_AIR:		stop_in_air();		break;
	case balloon_state.FLOAT:			float();			break;
}

function idle(){
	event_inherited();
	display_key();
}

function prepare(){
	image_index = 1;
	event_inherited();
	
	if (keyboard_check_pressed(ord("W"))){
		state = balloon_state.FLY_UP;
		instance_destroy(objDodo);
	}
}

function fly_up(){
	objCam.follow = objBalloon;
	image_index = 2;
	vspeed = lerp(vspeed, -fly_speed, 0.01);
	if (!level_goal and y <= stop_limit){
		state = balloon_state.STOP_IN_AIR;	
	}
	else if (y <5*tile_size){
		if (alarm[0] <= 0) alarm[0] = 100;
		instance_create_layer(x, y, "instances", objDarkSquare);
	}
}

function stop_in_air(){
	vspeed = lerp(vspeed, 0, 0.01);
	pan_camera = true;
	
	if (abs(vspeed) < 1){
		vspeed = 0;
		state = balloon_state.FLOAT;
		timer = -1;
	}
}


function float(){
	event_inherited();
}


function display_key(){
	if (point_distance(x, ystart, objGooseBody.x, objGooseBody.y) <= 20*pixel_size and objGooseBody.is_on_ground){
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

objBrazier.y = y;
objFire.y = y-21*pixel_size;