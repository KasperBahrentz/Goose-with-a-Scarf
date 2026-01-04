switch(state){
	case melon_state.ROLL:	roll();	break;
	case melon_state.SPLAT:	splat();	break; 
}

function roll(){
	// Check for support slightly ahead
	var _has_support = check_collision(roll_dir, 1)
	    || (place_meeting(x + roll_dir, y + 1, [objCollision, objCollisionSemiSolid]));

	// Horizontal movement
	if (_has_support)
	{
	    // Roll normally when grounded
	    hsp = roll_dir * roll_spd;
	}
	else
	{
	    // Lose sideways momentum in air
	    hsp = lerp(hsp, 0, 0.015);
	}

	// Apply horizontal movement
	x += hsp;

	// Gravity
	if (!_has_support)
	{
	    current_fall_spd += fall_spd;
	    current_fall_spd = min(current_fall_spd, max_fall_spd);
		audio_sound_gain(snd_inst_thunder, 0, 30);
	}
	else
	{
		audio_sound_gain(snd_inst_thunder, 1, 30);
	    current_fall_spd = 0;
	
		if (collision_start_timer > collision_start_limit) {
			while (check_collision(0, 0) || (place_meeting(0, 0, [objCollision, objCollisionSemiSolid])))
		    {
				y -= 1;
			}
		}
	}

	// Apply vertical movement
	y += current_fall_spd;


	// kill player on collision
	if (place_meeting(x, y, objGooseBody)){	
		objGooseBody.state = player_state.DIE;
		state = melon_state.SPLAT;
	}


	// destroy if off-screen
	if (y > room_height){
		instance_destroy();
	}

	// collide with crates
	if (place_meeting(x + roll_dir*pixel_size, y, prtCrate)){
		with instance_nearest(x, y, prtCrate){
			hp = 0;
		}
	}
	else // destroy self i colliding with wall
	if (collision_start_timer >= collision_start_limit){
		if (check_collision(roll_dir, -4*pixel_size)){
			state = melon_state.SPLAT;
		}
	}

	var _other = collision_circle(x, y, sprite_width/3, objMelon, false, true);

	if (_other != noone)
	{
	    state = melon_state.SPLAT;

	    with (_other)
	    {
	        state = melon_state.SPLAT;
	    }
	}


	if (collision_start_timer < collision_start_limit){
		collision_start_timer++;	
	}
}

function splat() {
	audio_stop_sound(snd_inst_thunder);
	screenshake(10, 2, 0.2);
	
	repeat(choose(1, 2, 2, 2, 3)){ // Down
		instance_create_layer(x, y, "instances", objMelonSplat, {splat_id: "down"});	
	}
	repeat(choose(1, 2, 2, 2, 3)){ // Left
		instance_create_layer(x, y, "instances", objMelonSplat, {splat_id: "left"});	
	}
	repeat(choose(1, 2, 2, 2, 3)){ // Right
		instance_create_layer(x, y, "instances", objMelonSplat, {splat_id: "right"});	
	}
	audio_sound_pitch(sndSplat, random_range(0.9, 1.1));
	audio_play_sound(sndSplat, 5, false);
	instance_destroy();	
}