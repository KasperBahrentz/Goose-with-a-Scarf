var _semi_solids_created = 0;
repeat(image_index+1){
	instance_create_layer(x + _semi_solids_created*tile_size + tile_size/2, y, "collision", objCollisionSemiSolid);	
	_semi_solids_created++;
}

if (get_tileset_name() == "tlsGroundSummer"){
	sprite_index = sprPuddleSummer;
}