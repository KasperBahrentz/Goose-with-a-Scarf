var dist = point_distance(x, y, objGooseBody.x, objGooseBody.y);
if (dist < player_range) {
    visible = true;
} else {
    visible = false;
}

// Smoothly animate scale if visible
if (visible) {
    scale = lerp(scale, target_scale, scale_speed);
} else {
    scale = lerp(scale, 0, scale_speed);
}

if (scale > 0.9 && text_index < string_length(text)) {
    if (text_pause > 0) {
        text_pause -= 1;
    } else {
        text_timer += text_speed;

        while (text_timer >= 1 && text_index < string_length(text)) {
            text_index += 1;
            text_timer -= 1;

            var current_char = string_char_at(text, text_index);
			
			// Play sound if not whitespace or punctuation (optional)
            if (current_char != " " && current_char != "." && current_char != "," && current_char != ":" && current_char != ";") {
                audio_sound_pitch(sndHonk, random_range(0.97, 1.03));
				audio_play_sound(sndHonk, 0, false);
            }

            // Pause on punctuation
            switch (current_char) {
                case ".":
                case "!":
                case "?":
                    text_pause = 15; break; // longer pause
                case ",":
                case ":":
                case ";":
                    text_pause = 8; break;  // short pause
            }

            // Optional: sound effect here
            // audio_play_sound(snd_type, 0, false);
        }
    }

    text_shown = string_copy(text, 1, text_index);
} else if (scale <= 0.9) {
    // Reset when bubble shrinks
    text_index = 0;
    text_timer = 0;
    text_shown = "";
    text_pause = 0;
}
