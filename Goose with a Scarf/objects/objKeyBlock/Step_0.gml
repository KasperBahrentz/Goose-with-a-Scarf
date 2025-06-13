switch (state) {
    case locked_state.LOCKED:
		check_for_unlock(middle_x, middle_y, open_distance);
	break;

    case locked_state.KEY_INSERTED:
        unlock_timer--;
        if (unlock_timer <= 0) {
            state = locked_state.UNLOCKED;
            unlock_timer = 40; // show unlocked frame
            image_index = 2;
        }
        break;

	case locked_state.UNLOCKED:
	    brightness += 0.03;
	    brightness = clamp(brightness, 0, 1);

	    if (brightness >= 1) {
	        state = locked_state.OPEN;
	        unlock_timer = 4;
	        image_index = 3;
	        audio_play_sound(sndDoor, 6, false);
	    }
	    break;

    case locked_state.OPEN:
	    repeat(30 + 15*confetti_factor) instance_create_layer(middle_x, middle_y, "instances", objConfetti);
        instance_destroy();
		audio_play_sound(sndBonus, 10, false);
    break;
}
