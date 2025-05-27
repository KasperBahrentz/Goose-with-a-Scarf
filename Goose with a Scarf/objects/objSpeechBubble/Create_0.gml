visible = false;         // Only shows when player is close
scale = 0;               // Start scaled down
target_scale = 1;        // Full size
scale_speed = 0.1;       // Speed of scaling
text = "Hello there, my lovely goose friend! I truly hope you are having the most wonderful of days!";   // Your message
text_margin = 30;        // Padding inside the bubble
player_range = 32*pixel_size;      // Distance to trigger the bubble

text_shown = "";             // What’s currently visible
text_index = 0;              // Current character index
text_speed = 0.5;            // Characters per frame (adjust as needed)
text_timer = 0;              // Fractional counter
text_pause = 0; // how many frames to wait on punctuation