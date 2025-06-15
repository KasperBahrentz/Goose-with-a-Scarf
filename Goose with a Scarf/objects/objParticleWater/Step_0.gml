// Gravity
_vspeed += 0.3;

// Move
x += _hspeed;
y += _vspeed;



// Ground collision check (assuming ground is solid or y-based)
if ((_vspeed > 0) and ((place_meeting(x, y, objCollision) or (check_collision(0, 0))))){
	life -= 5;
	image_index = 1;
}

if (life <= life_start/2 and image_index == 0) image_index = 1;

if (life <= 0) instance_destroy();

// Life and fade
life -= 1;
image_alpha = life / fade_factor;