event_inherited();

if (fruit != noone){
	if (array_contains(objGame.fruit_collected, room_get_name(room))){
		instance_create_depth(x, y, depth, objCrateBig);
		instance_destroy();
	}	
}
