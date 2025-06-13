// Base flicker values for a chill campfire
var twinkle_range = 0.2;
var base_alpha = 0.6;

// Soft, slightly randomized flicker
var flicker_noise = sin(flicker_phase) + random_range(-0.2, 0.2);
var twinkle = flicker_noise * twinkle_range + base_alpha;
var alpha_val = clamp(twinkle, 0.3, 0.9);

// Gentle scale variation
var scale_variation = random_range(0.98, 1.02);

// Static warm light base
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, 1);

// Warm flickering glow
var campfire_colour = make_colour_rgb(255, 170, 80); // Soft orange
gpu_set_blendmode_ext(bm_src_alpha, bm_one);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * scale_variation, image_yscale * scale_variation, 0, campfire_colour, alpha_val);
gpu_set_blendmode(bm_normal);
