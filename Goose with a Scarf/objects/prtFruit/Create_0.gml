/// @description Insert description here
// You can write your code in this editor

if (array_contains(objGame.fruit_collected, room_get_name(room))){
	instance_destroy();	
}

enum fruit_state {
	ITEM,
	FOLLOW,
	COLLECT
}

fruit_index = fruit_counter.PEAR;

switch (sprite_index){
	case sprPear:		fruit_index = fruit_counter.PEAR;		break;	
	case sprStrawberry:	fruit_index = fruit_counter.STRAWBERRY;	break;
	case sprGrape:		fruit_index = fruit_counter.GRAPE;		break;
	case sprOrange:		fruit_index = fruit_counter.ORANGE;		break;
}

state = fruit_state.ITEM;

// Inherit the parent event
event_inherited();

img_speed = image_speed;
image_speed = 0;

