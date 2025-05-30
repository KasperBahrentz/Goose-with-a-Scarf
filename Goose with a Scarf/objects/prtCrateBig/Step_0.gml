/// @description Insert description here
// You can write your code in this editor

event_inherited();

if (fruit != noone){
	if (array_contains(objGame.fruit_collected, room_get_name(room))){
		instance_create_layer(x, y, "instances", objCrateBig);
		instance_destroy();
	}	
}

switch(hp){
	case 2:	image_index = start_broken ? 1 : 0;	break;
	case 1:	image_index = 2;					break;
}