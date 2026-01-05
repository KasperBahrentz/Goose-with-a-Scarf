/// @description Insert description here
// You can write your code in this editor

start_y = y;

start_depth = objGooseBody.depth+1;

has_created_respawn = false;

if (temporary){
	depth += 1;
	image_index = temporary_index;
	if (array_length(spawn_coordinate) == 0){
		sprite_index = sprEggMelon;
	}
	else {
		sprite_index = sprEggTemporary;
	}
}

index = 0;

alarm[1] = 8;

enum egg_state{
	IDLE,
	MOVE,
	DROP
}

image_speed = 0;

just_picked_up = false;

my_queue = [];

has_collided = false;

if (state == egg_state.MOVE){
	add_to_egg_queue();
}

function add_to_egg_queue(){
	array_push(objGooseBody.egg_queue, egg_id);
}