// State machine states
state = locked_state.LOCKED;

// Distance threshold for detecting player
open_distance = 60*pixel_size; // or whatever feels right

brightness = 0;
pulse_phase = 0;

unlock_timer = 0;

middle_x = x + floor(sprite_width/2);
middle_y = y + floor(sprite_height/2);

confetti_factor = floor((sprite_width/pixel_size)/16) + floor((sprite_height/pixel_size)/16)

depth = objGooseBody.depth + 20;