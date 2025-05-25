/// @description Insert description here
// You can write your code in this editor

enum chest_state {
    LOCKED,
    KEY_INSERTED,
    UNLOCKED,
    OPENING,
    OPEN
}


// State machine states
state = chest_state.LOCKED;

// Timers
unlock_timer = 0;

// Distance threshold for detecting player
open_distance = 64; // or whatever feels right

depth = objGooseBody.depth + 20;