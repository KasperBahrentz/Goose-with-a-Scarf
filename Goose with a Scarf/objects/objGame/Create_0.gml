/// @description Insert description here
// You can write your code in this editor

egg_count = 0;

window_set_fullscreen(true);

tile_size = 128;
pixel_size = 8;

// Screen shake
shake = false;
shake_time = 0;
shake_magnitude = 0;
shake_fade = 0.25;

audio_play_sound(sndRunningWater, 3, true);