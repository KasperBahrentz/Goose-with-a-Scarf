if (instance_exists(flower)){
	if (flower.is_landed_on){
		flower.draw_y = ystart;
		y = ystart;
		timer = 0;
	}
	else {
		fly();
		flower.draw_y = y;	
	}
}
else if(instance_exists(flower_bud)){
	fly();
	flower_bud.y = y;		
}

function fly() {
	y = min(ystart, y-sin(timer) / 4);
	timer += 0.02;
}

if (sound_timer <= 0 ){
	if (distance_to_object(objGooseBody) <= sound_treshold){
		audio_sound_gain(sndPropeller, 1, 60);
	}
	else audio_sound_gain(sndPropeller, 0.5, 260);
	audio_sound_pitch(sndPropeller, random_range(0.9, 1));
	if(!audio_is_playing(sndPropeller)) audio_play_sound(sndPropeller, 2, false);
	sound_timer = sound_timer_max + irandom_range(-2, 2);
}
else {
	sound_timer--;	
}