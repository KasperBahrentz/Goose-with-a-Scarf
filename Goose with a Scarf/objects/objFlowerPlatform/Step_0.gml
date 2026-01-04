/// @description Insert description here
// You can write your code in this editor

switch(state){
	case flower_state.BUD:		bud();		break;
	case flower_state.PLATFORM:	platform();	break;
}

function platform(){
	image_index = 0;
	var _goose_on_top = collision_rectangle(bbox_left, bbox_top-4*pixel_size, bbox_right, bbox_bottom, objGooseBody, false, true)
		and objGooseBody.vspeed >= 0;
	var _melon_on_top = collision_rectangle(bbox_left, bbox_top-4*pixel_size, bbox_right, bbox_bottom, objMelon, false, true);
	var _crate_on_top = collision_rectangle(bbox_left, bbox_top-4*pixel_size, bbox_right, bbox_bottom, prtCrate, false, true);
	
	if (_goose_on_top || _melon_on_top || _crate_on_top){
		is_landed_on = true;
	}
	else is_landed_on = false;
}

function bud(){
	var _bud = noone;
	if (color == flower_color.RED){
		_bud = instance_create_layer(x, y, "instances", objFlowerBudRed, {leaf_propeller : leaf_propeller});
	}
	else _bud = instance_create_layer(x, y, "instances", objFlowerBudBlue, {leaf_propeller : leaf_propeller});
	leaf_propeller.flower_bud = _bud;
	instance_destroy();
}