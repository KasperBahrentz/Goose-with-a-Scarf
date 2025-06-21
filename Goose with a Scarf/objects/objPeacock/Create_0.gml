enum peacock_state {	
	QUIET,
	SING,
}

state = peacock_state.QUIET;

sprite_beak = sprPeacockBeak;

sprite_index = sprPeacockIdleHair;

quiet_timer = 240;
sing_timer = 240;

music_timer_max = 60;
music_timer = music_timer_max;