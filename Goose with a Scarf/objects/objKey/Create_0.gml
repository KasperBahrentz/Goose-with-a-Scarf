/// @description Insert description here
// You can write your code in this editor

event_inherited();

enum key_state {
	IDLE,
	FOLLOW	,
	TO_TARGET
}

count_follow = 0;

state = key_state.IDLE;

target_instance = noone;

// Distance threshold for detecting player
collect_distance = 6*pixel_size; // or whatever feels right