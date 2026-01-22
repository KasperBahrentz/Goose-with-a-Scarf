if (instance_exists(flower)){
	if (flower.is_landed_on){
		draw_y = ystart;
		timer = 0;
	}
	else {
		fly();
	}
}
else if(instance_exists(flower_bud)){
	fly();
}

function fly() {
	timer += 0.02;
	draw_y = min(ystart, draw_y-sin(timer) / 4);
}

if (sound_timer <= 0 ){
	if (distance_to_object(objGooseBody) <= sound_treshold){
		audio_sound_gain(sndPropeller, 0.2, 60);
	}
	else audio_sound_gain(sndPropeller, 0.1, 260);
	audio_sound_pitch(sndPropeller, random_range(0.9, 1));
	if(!audio_is_playing(sndPropeller)) audio_play_sound(sndPropeller, 2, false);
	sound_timer = sound_timer_max + irandom_range(-2, 2);
}
else {
	sound_timer--;	
}