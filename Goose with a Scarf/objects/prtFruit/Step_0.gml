/// @description Insert description here
// You can write your code in this editor

if (place_meeting(x, y, objGooseBody)){
	audio_sound_pitch(sndBlub, random_range(0.8, 0.9));
	if (!follow_player){
		audio_play_sound(sndBlub, 5, false); 
		image_index++;
		y -= 4*pixel_size;
	}
	follow_player = true;	
}

var _lerp_amount = 0.1;

if (follow_player){
	if (objGooseBody.vspeed == 0){
		image_speed = img_speed;
		
		if (!audio_is_playing(sndFruit2)) audio_play_sound(sndFruit2, 15, false);
	}
	else {
		x = lerp(x, objGooseBody.x, _lerp_amount);
		y = lerp(y, objGooseBody.y-16*pixel_size, _lerp_amount);
	}	
	
	if (image_index >= image_number-1){
		instance_destroy();	
	}
}
else {
	event_inherited();	
}