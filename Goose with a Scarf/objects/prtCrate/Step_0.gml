/// @description Insert description here
// You can write your code in this editor

if (hp <= 0){
	repeat(random_range(frag_min, frag_max)) instance_create_layer(x, y, "instances", objCrateFragment);
	audio_sound_pitch(sndCrateDestroy, random_range(0.9, 1.1));
	audio_play_sound(sndCrateDestroy, 7, false);
	instance_destroy();	
}