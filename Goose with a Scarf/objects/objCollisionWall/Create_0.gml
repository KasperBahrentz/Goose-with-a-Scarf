/// @description Insert description here
// You can write your code in this editor

if (y > -16*objGame.pixel_size * 16){
	instance_create_layer(x, y-16*objGame.pixel_size, "collision", objCollisionWall);	
}