/// @description Insert description here
// You can write your code in this editor

var _inst = collision_circle(x, y-2*pixel_size, 8*pixel_size, objEgg, false, false);

if (_inst != noone and _inst.state == egg_state.IDLE){
	image_index = 0;
	if (is_flying){
		_inst.y = y-2*pixel_size;	
	}
}
else image_index = 1;

if (is_flying){
	event_inherited();
	if(wings!= noone) wings.y = y;
}