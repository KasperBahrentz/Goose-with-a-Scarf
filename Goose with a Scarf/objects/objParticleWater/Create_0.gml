// Random splash angle, mostly upward with spread
direction = random_range(70, 110); // angle in degrees

if (instance_exists(objPuddle)) depth = objPuddle.depth - 10;

image_index = choose(0, 1, 1, 1);

speed = random_range(2, 3 + image_index); // how fast it shoots out

// Convert to components
_hspeed = lengthdir_x(speed, direction);
_vspeed = lengthdir_y(speed, direction);

// Fade out over time
life = 60 + irandom(60);
life_start = life;
image_alpha = 1;

fade_factor = irandom_range(5, 30);