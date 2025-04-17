/// @description Insert description here
// You can write your code in this editor

index = 0;

alarm[1] = 8;

enum egg_state{
	IDLE,
	MOVE,
	DROP
}

image_speed = 0;

if (state == egg_state.MOVE){
	add_to_egg_queue();
}

just_picked_up = false;

my_queue = [];

has_collided = false;

function add_to_egg_queue(){
	objGooseBody.egg_queue = array_concat(objGooseBody.egg_queue, [egg_id]);	
	depth += egg_id;
}