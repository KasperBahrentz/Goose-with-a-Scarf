var twinkle_speed = 0.02;
var twinkle_range = 0.6;
var base_alpha = 0.8;

var twinkle = sin(timer * twinkle_speed) * twinkle_range + base_alpha;
var alpha_val = clamp(twinkle, 0, 1);

var pale_yellow = make_colour_rgb(255, 255, 153);

// Draw the star with changing alpha (fading in/out)
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, alpha_val);

// Draw additive glow with pale yellow color
gpu_set_blendmode_ext(bm_src_alpha, bm_one);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, pale_yellow, alpha_val);
gpu_set_blendmode(bm_normal);
