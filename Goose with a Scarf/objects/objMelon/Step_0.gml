// Check for support slightly ahead
var _has_support = check_collision(roll_dir * sprite_width / 3, 1)
    || ( place_meeting(x + roll_dir * sprite_width / 3, y + 1, objCollision));

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

// Roll animation scales with horizontal speed
image_index += animate_spd * sign(hsp);

// Gravity
if (!_has_support)
{
    current_fall_spd += fall_spd;
    current_fall_spd = min(current_fall_spd, max_fall_spd);
}
else
{
    current_fall_spd = 0;
	
	if (collision_start_timer > collision_start_limit) {
		while (check_collision(0, 0) || (place_meeting(0, 0, objCollision)))
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
	instance_destroy();
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
		instance_destroy();
	}
}

if (place_meeting(x + roll_dir*pixel_size, y, objMelon)){
	with instance_nearest(x, y, objMelon){
		instance_destroy();
	}
}

if (collision_start_timer < collision_start_limit){
	collision_start_timer++;	
}