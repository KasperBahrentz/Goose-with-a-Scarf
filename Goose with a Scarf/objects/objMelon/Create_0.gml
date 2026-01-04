enum melon_state {
	ROLL,
	SPLAT
}

state = melon_state.ROLL;

current_fall_spd = 0;
max_fall_spd = 12;
collision_start_timer = 0;
collision_start_limit = 30;

depth = objGooseBody.depth - 30;

snd_inst_thunder = audio_play_sound(
    sndThunder,
    3,
    true,
    1,
    random(10)
);

audio_sound_pitch(snd_inst_thunder, random_range(0.9, 1.1));