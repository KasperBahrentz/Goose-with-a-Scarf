if (state == player_state.SIT) {
	state = player_state.MOVE;
	sprite_index = spr_body_idle;
	objGooseFeet.sprite_index = spr_feet_idle;
	idle_timer = idle_timer_max + irandom_range(0, idle_timer_max / 3);
}