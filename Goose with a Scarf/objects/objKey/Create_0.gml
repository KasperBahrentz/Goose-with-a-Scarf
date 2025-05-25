/// @description Insert description here
// You can write your code in this editor

event_inherited();

enum key_state {
	IDLE,
	FOLLOW	,
	TO_CHEST
}

state = key_state.IDLE;

// Distance threshold for detecting player
open_distance = 6*pixel_size; // or whatever feels right