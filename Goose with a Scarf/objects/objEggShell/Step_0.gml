/// @description Insert description here
// You can write your code in this editor

speed /= 1.5;

if (speed <= 16){
	image_alpha /= 1.1;
}

if (speed <= 1){
	instance_destroy();
}