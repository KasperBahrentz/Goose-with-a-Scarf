switch(state) {
	case peacock_state.QUIET:	quiet()	break;
	case peacock_state.SING:	sing()	break;
}

function quiet() {
	sprite_beak = sprPeacockQuiet;
	if (alarm[0] <= 0) alarm[0] = quiet_timer + irandom(quiet_timer);
}


function sing() {
	sprite_beak = sprPeacockSing;
	if (alarm[1] <= 0) alarm[1] = sing_timer + irandom(sing_timer);

	if (music_timer <= 0){
		instance_create_layer(x+10*pixel_size, y-22*pixel_size, "instances", objMusicNote);	
		music_timer = music_timer_max + irandom(music_timer_max/2);
	}
	else music_timer--;
}