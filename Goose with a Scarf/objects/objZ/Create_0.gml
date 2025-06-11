// Sprite growth
image_index = 0;
image_speed = 0.025; // Slower growth

// Zig-zag curve params
_base_x = x;               // Start x-position
_amplitude = 30 + random(20); // How wide the zig-zag is
_frequency = 0.04 + random(0.02); // How fast it wiggles
_phase = degtorad(90 + random_range(-20, 20));

// Track previous wave value
_wave_last = sin(_phase); // starts at 0

// Vertical motion
_vspeed = -0.5 - random(0.3); // How fast it rises

// Lifespan
_life = 200 + irandom(50);
_timer = 0;

// Alpha
image_alpha = 1;
	
depth = objOwl.depth - 20;

