/// @description Insert description here
// You can write your code in this editor

if (hp <= 0){
	var _x = x + sprite_width/2;
	var _y = y + sprite_height/2;

	repeat(random_range(frag_min, frag_max)){ // Up	
		instance_create_layer(_x, _y, "instances", objCrateFragment, {spawn_direction: "up"});
	}
	repeat(random_range(frag_min, frag_max)){ // Down
		instance_create_layer(_x, _y, "instances", objCrateFragment, {spawn_direction: "down"});
	}
	repeat(random_range(frag_min, frag_max)){ // Left
		instance_create_layer(_x, _y, "instances", objCrateFragment, {spawn_direction: "left"});
	}
	repeat(random_range(frag_min, frag_max)){ // Right
		instance_create_layer(_x, _y, "instances", objCrateFragment, {spawn_direction: "right"});
	}
	
	
	if (extra_frag != noone) repeat(random_range(frag_min, frag_max)) instance_create_layer(_x, _y, "instances", extra_frag);
	audio_sound_pitch(sndCrateDestroy, random_range(0.9, 1.1));
	audio_play_sound(sndCrateDestroy, 7, false);
	if (fruit != noone){
		audio_play_sound(sndBonus, 7, false);
		instance_create_layer(_x, _y, "instances", fruit);	
	}
	instance_destroy();	
}