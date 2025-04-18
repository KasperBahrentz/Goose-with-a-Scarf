/// @description Insert description here
// You can write your code in this editor

audio_sound_pitch(sndPop, 0.85);
audio_play_sound(sndPop, 5, false);

// Spawn at appropriate position
var _x = objGooseBody.x;
var _y = objGooseBody.y;

if (spawn_at_nest){
	instance_create_layer(spawn_coordinate[0], spawn_coordinate[1], "instances", objEgg, {egg_id : egg_id, temporary : true, spawn_coordinate : spawn_coordinate, temporary_index : temporary_index});
}
else instance_create_layer(_x,_y, "instances", objEgg, {state : egg_state.MOVE});
instance_destroy();