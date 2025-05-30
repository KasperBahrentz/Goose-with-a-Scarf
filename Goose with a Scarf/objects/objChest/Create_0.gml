/// @description Insert description here
// You can write your code in this editor

enum chest_state {
    LOCKED,
    KEY_INSERTED,
    UNLOCKED,
    OPENING,
    OPEN
}

if (array_contains(objGame.fruit_collected, room_get_name(room))){
	image_index = 4;
	state = chest_state.OPEN;
}


// State machine states
state = chest_state.LOCKED;

// Timers
unlock_timer = 0;

// Distance threshold for detecting player
open_distance = 20*pixel_size; // or whatever feels right

depth = objGooseBody.depth + 20;