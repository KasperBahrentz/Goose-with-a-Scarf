// Sprite growth
// Initialization (put this when the note is created)
base_index = choose(0, 3, 6, 9, 12, 15, 18); // Or however many options you have
image_index = base_index;
image_speed = 0.025; // Slower growth

max_growth = choose(2, 2, 1);

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
_life = 400 + irandom(200);
_timer = 0;

// Alpha
image_alpha = 1;
	
depth = objPeacock.depth - 20;

