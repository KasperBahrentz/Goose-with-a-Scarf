/// @description Insert description here
// You can write your code in this editor

var _is_rock = object_index == objRock || object_is_ancestor(object_index, objRock);

if (hp <= 0 && !_is_rock){
	var _x = x + sprite_width/2;
	var _y = y + sprite_height/2;

	repeat(irandom_range(frag_min, frag_max)){ // Up	
		instance_create_layer(_x, _y, "instances", objCrateFragment, {spawn_direction: "up"});
	}
	repeat(irandom_range(frag_min, frag_max)){ // Down
		instance_create_layer(_x, _y, "instances", objCrateFragment, {spawn_direction: "down"});
	}
	repeat(irandom_range(frag_min, frag_max)){ // Left
		instance_create_layer(_x, _y, "instances", objCrateFragment, {spawn_direction: "left"});
	}
	repeat(irandom_range(frag_min, frag_max)){ // Right
		instance_create_layer(_x, _y, "instances", objCrateFragment, {spawn_direction: "right"});
	}
	
	
	if (extra_frag != noone) repeat(irandom_range(frag_min, frag_max)) instance_create_layer(_x, _y, "instances", extra_frag);
	audio_sound_pitch(sndCrateDestroy, random_range(0.9, 1.1));
	audio_play_sound(sndCrateDestroy, 7, false);
	if (fruit != noone){
		audio_play_sound(sndBonus, 7, false);
		instance_create_layer(_x, _y, "instances", fruit);	
	}
	instance_destroy();	
}


current_fall_spd = min(current_fall_spd + fall_spd, max_fall_spd);

if (check_collision(0, current_fall_spd)
|| place_meeting(x, y + current_fall_spd, [objCollision, objCollisionSemiSolid]))
{
    // Snap to surface
    current_fall_spd = 0;
}
else
{
    y += current_fall_spd;
	
	if (place_meeting(x, y, objGooseBody)){
		objGooseBody.state = player_state.DIE;	
		hp = 0;
	}
	
	var _melon = instance_place(x, y, objMelon);
	
	if (_is_rock && _melon != noone){
		_melon.state = melon_state.SPLAT;
	}
}

