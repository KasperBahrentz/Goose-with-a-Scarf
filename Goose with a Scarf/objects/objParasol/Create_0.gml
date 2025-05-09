/// @description Insert description here
// You can write your code in this editor

enum parasol_state{
	CLOSED,
	OPEN	
}

enum sprite_state{
	ITEM,
	OPEN_RIGHT,
	CLOSED_RIGHT,
	OPEN_LEFT,
	CLOSED_LEFT	
}


state = parasol_state.CLOSED;

timer = 0;
timer_speed = 0.03;

depth -= 20;