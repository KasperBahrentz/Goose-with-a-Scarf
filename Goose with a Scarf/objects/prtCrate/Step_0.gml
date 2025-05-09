/// @description Insert description here
// You can write your code in this editor

if (hp <= 0){
	var _x = x + sprite_width/2;
	var _y = y + sprite_height/2;
	repeat(random_range(frag_min, frag_max)) instance_create_layer(_x, _y, "instances", objCrateFragment);
	if (extra_frag != noone) repeat(random_range(frag_min, frag_max)) instance_create_layer(_x, _y, "instances", extra_frag);
	audio_sound_pitch(sndCrateDestroy, random_range(0.9, 1.1));
	audio_play_sound(sndCrateDestroy, 7, false);
	if (fruit != noone){
		audio_play_sound(sndBonus, 7, false);
		instance_create_layer(_x, _y, "instances", fruit);	
	}
	instance_destroy();	
}