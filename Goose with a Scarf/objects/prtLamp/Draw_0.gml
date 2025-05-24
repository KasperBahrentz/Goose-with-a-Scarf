// Base lamp body
draw_sprite(sprite_index, 0, x, y);

// Flicker alpha
var twinkle_range = 0.3;
var base_alpha = 0.4;

var twinkle = sin(flicker_phase) * twinkle_range + base_alpha;
var alpha_val = clamp(twinkle, 0.2, 0.9);

// Static semi-transparent light part
draw_sprite_ext(sprite_index, 1, x, y, image_xscale, image_yscale, 0, c_white, 0.6);

// Flickering glow
var pale_yellow = make_colour_rgb(255, 255, 153);
gpu_set_blendmode_ext(bm_src_alpha, bm_one);
draw_sprite_ext(sprite_index, 1, x, y, image_xscale, image_yscale, 0, pale_yellow, alpha_val);
gpu_set_blendmode(bm_normal);
