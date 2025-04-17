/// @description Insert description here
// You can write your code in this editor

audio_sound_pitch(sndPop, 0.85 + egg_id*0.01);
audio_play_sound(sndPop, 5, false);

var _egg_id = array_last(objGooseBody.egg_queue);
var _x = objGooseBody.x;
var _y = objGooseBody.y;

for (var i = 0; i < instance_number(objEgg); i++){
	var _inst = instance_find(objEgg, i);
	if (_inst.egg_id = _egg_id){
		_x = _inst.x;
		_y = _inst.y;
	}
}

if (spawn_at_nest){
	instance_create_layer(spawn_coordinate[0], spawn_coordinate[1], "instances", objEgg, {egg_id : egg_id, temporary : true, spawn_coordinate : spawn_coordinate});
}
else instance_create_layer(_x,_y, "instances", objEgg, {egg_id : egg_id, state : egg_state.MOVE});
instance_destroy();