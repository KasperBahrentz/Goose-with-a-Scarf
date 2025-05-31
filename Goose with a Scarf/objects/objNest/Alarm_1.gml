/// @description Insert description here
// You can write your code in this editor


if (!check_collision(0, 0) and !place_meeting(x , y+2*pixel_size, objCollisionSemiSolid)){
	is_flying = true;	

	if (is_flying){
		wings = instance_create_layer(x, y, "instances", objNestWings);	
	}
}
