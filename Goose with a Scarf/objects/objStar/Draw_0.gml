// In the Draw event of each star
var twinkle_speed = 0.015; // smaller = slower twinkle
var twinkle_range = 0.6;  // range of twinkle (0 to 1)
var base_alpha = 0.8;     // how bright at rest

var twinkle = sin(timer * twinkle_speed) * twinkle_range + base_alpha;
draw_set_alpha(clamp(twinkle, 0, 1));
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, image_alpha);
draw_set_alpha(1); // reset alpha after drawing