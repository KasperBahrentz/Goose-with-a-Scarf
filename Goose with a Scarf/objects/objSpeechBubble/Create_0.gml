visible = false;         // Only shows when player is close
text_margin = 48;        // Padding inside the bubble
player_range = 32*pixel_size;      // Distance to trigger the bubble

text_shown = "";             // What’s currently visible
text_index = 0;              // Current character index
default_text_speed = 0.8;
text_speed = default_text_speed;   // Characters per frame (adjust as needed)
text_timer = 0;              // Fractional counter
text_pause = 0; // how many frames to wait on punctuation

draw_y = 0;
draw_x = 0;

space_between_lines = 10 * pixel_size;
max_line_width = 100 * pixel_size;
bubble_h = 0;

sound = sndTypewriter;
sound_timer_max = 4;
sound_timer = 0;

fade = false;

signature_color = c_ltgray;

// Check if spawned in player circumference
var dist = point_distance(x+4*pixel_size, y, objGooseBody.x, objGooseBody.y);
if (dist < player_range) {
	text_speed = 100;
	sound_timer = 100;
}
