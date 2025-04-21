/// @description Insert description here
// You can write your code in this editor

if (y > -10*pixel_size * 16){
	instance_create_layer(x, y-16*pixel_size, "collision", objCollisionWall);	
}