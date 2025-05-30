var dist = point_distance(x+4*pixel_size, y, objGooseBody.x, objGooseBody.y);
if (dist < player_range) {
    visible = true;
	fade = false;
	image_alpha = 1;
} else {
    fade = true;
	text_speed = default_text_speed;
}


if (fade){
	image_alpha = lerp(image_alpha, 0, 0.3);	
	if (image_alpha <= 0.1){
		visible = false;
		fade = false;
		image_alpha = 1;
	}
}

if (visible and text_index < string_length(text)) {
    if (text_pause > 0) {
        text_pause -= 1;
    } else {
        text_timer += text_speed;

        while (text_timer >= 1 && text_index < string_length(text)) {
            text_index += 1;
            text_timer -= 1;

            var current_char = string_char_at(text, text_index);

			
			if (sound_timer <= 0){
					audio_sound_pitch(sound, random_range(0.8, 1.2));
					audio_play_sound(sound, 0, false);
					sound_timer = sound_timer_max + irandom_range(0, 3);
			}
			else {
				sound_timer--;	
			}
			
						
			if (current_char == "." || current_char == "!" || current_char == "?"){
				sound_timer = sound_timer_max*2;	
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
        }
    }

    text_shown = string_copy(text, 1, text_index);
} else if (!visible) {
    // Reset when bubble shrinks
    text_index = 0;
    text_timer = 0;
    text_shown = "";
    text_pause = 0;
	sound_timer = 0;
}