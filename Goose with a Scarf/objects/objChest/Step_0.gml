switch (state) {
    case locked_state.LOCKED:
		check_for_unlock(x, y, open_distance);
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
        unlock_timer--;
        if (unlock_timer <= 0) {
            state = locked_state.OPENING;
            unlock_timer = 4; // brief pause at half-open
            image_index = 3;
			audio_play_sound(sndDoor, 6, false);
        }
        break;

    case locked_state.OPENING:
        unlock_timer--;
        if (unlock_timer <= 0) {
            image_index = 4;
            state = locked_state.OPEN;
			audio_play_sound(sndBonus, 7, false);
			instance_create_layer(x, y-20*pixel_size, "instances", fruit);	
        }
        break;

    case locked_state.OPEN:
        // Fully open. Spawn loot, stay idle, etc.
        break;
}
