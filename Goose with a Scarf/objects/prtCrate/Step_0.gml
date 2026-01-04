/// @description Insert description here
// You can write your code in this editor

if (hp <= 0){
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


var _has_support = check_collision(0, 1)
    || (place_meeting(x, y + 1, [objCollision, objCollisionSemiSolid]));

// Gravity
if (!_has_support)
{
    current_fall_spd += fall_spd;
    current_fall_spd = min(current_fall_spd, max_fall_spd);
	
	if (place_meeting(x, y, objGooseBody)){
		hp = 0;
		with(objGooseBody){
			state = player_state.DIE;	
		}
	}
}
else
{
    current_fall_spd = 0;
	
	while (check_collision(0, 0) || (place_meeting(0, 0, [objCollision, objCollisionSemiSolid])))
	{
		y -= 1;
	}
}

// Apply vertical movement
y += current_fall_spd;