/// @description Insert description here
// You can write your code in this editor

if (!instance_exists(objCam)) instance_create_layer(x, y, "instances", objCam);

egg_count = 0;

window_set_fullscreen(true);

tile_size = 128;
pixel_size = 8;

audio_play_sound(sndRunningWater, 3, true);
