// Normal sprite pass
draw_set_alpha(1);
draw_set_color(c_white);
draw_self();
draw_sprite_custom(sprKeyhole, image_index, middle_x, middle_y, 1, 1);


// Additive glow if unlocked
if (state == locked_state.UNLOCKED) {
    var pale_yellow = make_colour_rgb(255, 220, 30);
    var alpha_val = brightness * 0.75; // Adjust intensity

    gpu_set_blendmode_ext(bm_src_alpha, bm_one); // additive
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, pale_yellow, alpha_val);
    gpu_set_blendmode(bm_normal);
}