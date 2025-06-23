enum peacock_state {	
	QUIET,
	SING,
}

state = peacock_state.QUIET;

sprite_beak = sprPeacockQuiet;

sprite_index = sprPeacockHairIdle;

quiet_timer = 240;
sing_timer = 400;

music_timer_max = 80;
music_timer = music_timer_max;