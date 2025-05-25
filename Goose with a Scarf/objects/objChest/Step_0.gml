switch (state) {
    case chest_state.LOCKED:
        if (distance_to_object(objGooseBody) < open_distance) {
			if (instance_exists(objKey) and objKey.state == key_state.FOLLOW){
				objKey.state = key_state.TO_CHEST;
			}
        }
        break;

    case chest_state.KEY_INSERTED:
        unlock_timer--;
        if (unlock_timer <= 0) {
            state = chest_state.UNLOCKED;
            unlock_timer = 40; // show unlocked frame
            image_index = 2;
        }
        break;

    case chest_state.UNLOCKED:
        unlock_timer--;
        if (unlock_timer <= 0) {
            state = chest_state.OPENING;
            unlock_timer = 4; // brief pause at half-open
            image_index = 3;
			audio_play_sound(sndDoor, 6, false);
        }
        break;

    case chest_state.OPENING:
        unlock_timer--;
        if (unlock_timer <= 0) {
            image_index = 4;
            state = chest_state.OPEN;
			audio_play_sound(sndBonus, 7, false);
			instance_create_layer(x, y-20*pixel_size, "instances", fruit);	
        }
        break;

    case chest_state.OPEN:
        // Fully open. Spawn loot, stay idle, etc.
        break;
}
