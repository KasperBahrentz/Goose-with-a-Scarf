var _inst = instance_create_layer(x + sprite_width/2, y, "collision", objCollisionSemiSolid);

switch(image_index){
	case 0:	_inst.image_xscale *= 2;	break;
	case 1:	_inst.image_xscale *= 4;	break;
}