var twinkle_speed = 0.02;
var twinkle_range = 0.6;
var base_alpha = 0.7;

// Calculate twinkle value oscillating roughly between (base_alpha - twinkle_range) and (base_alpha + twinkle_range)
var twinkle = sin(timer * twinkle_speed) * twinkle_range + base_alpha;
var alpha_val = clamp(twinkle, 0, 1);

// Draw the star with changing alpha (fading in/out)
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, alpha_val);

// Draw the additive yellow glow on top, brightness scaled by alpha_val (or tweak as you like)
gpu_set_blendmode_ext(bm_src_alpha, bm_one);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_yellow, alpha_val);
gpu_set_blendmode(bm_normal);
