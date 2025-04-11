/// @description Insert description here
// You can write your code in this editor

if (image_index >= image_number/2){
	image_alpha *= 0.9;	
}
speed *= 0.9;

if (speed <= 1){
	instance_destroy();
}