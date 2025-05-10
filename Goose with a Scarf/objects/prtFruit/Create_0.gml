/// @description Insert description here
// You can write your code in this editor

enum fruit_state {
	ITEM,
	FOLLOW,
	COLLECT
}

image_index++;

fruit_index = fruit_counter.PEAR;

switch (sprite_index){
	case sprPear:		fruit = fruit_counter.PEAR;			break;	
	case sprStrawberry:	fruit = fruit_counter.STRAWBERRY;	break;
	case sprGrape:		fruit = fruit_counter.GRAPE;		break;
	case sprOrange:		fruit = fruit_counter.ORANGE;		break;
}

state = fruit_state.ITEM;

// Inherit the parent event
event_inherited();

img_speed = image_speed;
image_speed = 0;

