/// @description Insert description here
// You can write your code in this editor

var _pop_sound = choose(sndPop, sndPop2);
audio_sound_pitch(_pop_sound, random_range(0.85, 1.1));

if (!audio_is_playing(sndPop2) and !audio_is_playing(sndPop)) audio_play_sound(_pop_sound, 5, false);

// Spawn at appropriate position
var _x = objGooseBody.x;
var _y = objGooseBody.y;

if (spawn_at_nest){
	if (array_length(spawn_coordinate) > 0) instance_create_layer(spawn_coordinate[0], spawn_coordinate[1], "instances", objEgg, {egg_id : egg_id, temporary : true, spawn_coordinate : spawn_coordinate, temporary_index : temporary_index});
}
else instance_create_layer(_x,_y, "instances", objEgg, {state : egg_state.MOVE});
instance_destroy();