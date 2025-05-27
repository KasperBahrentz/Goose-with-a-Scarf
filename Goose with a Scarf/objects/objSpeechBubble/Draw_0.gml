if (scale > 0.01) {
	var _space_between_lines =  6*pixel_size;
	var _max_line_width = 100*pixel_size;
	
    var text_w = string_width_ext(text, _space_between_lines, _max_line_width);
	var text_h = string_height_ext(text, _space_between_lines, _max_line_width);

    // Define the full bubble size (padding comes from the sprite's nine-slice)
    var bubble_w = (text_w + text_margin * 2) * scale;
    var bubble_h = (text_h + text_margin * 2) * scale;

    // Draw the nine-slice bubble centered on (x, y)
    draw_sprite_ext(
        sprite_index, image_index,
        x, y,
        bubble_w / sprite_get_width(sprite_index),
        bubble_h / sprite_get_height(sprite_index),
        0, c_white, 1
    );
	

    // Only draw text once bubble is nearly full size
    if (scale > 0.7) {
        // Compute draw position for the text within the inner box
        var text_x = x + text_margin;
        var text_y = y - bubble_h + text_margin;

        draw_text_ext(text_x, text_y, text_shown, _space_between_lines, _max_line_width);
    }
	
	while (text_timer >= 1) {
	    text_index += 1;
	    text_timer -= 1;
	    audio_play_sound(sndHonk, 2, false);
	}
}
