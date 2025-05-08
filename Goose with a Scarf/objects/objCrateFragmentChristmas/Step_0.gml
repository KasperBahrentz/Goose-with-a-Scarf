/// @description Insert description here
// You can write your code in this editor

speed *= 0.85;

if (speed < initial_speed/3){
	image_alpha *= 0.99;
}

if (speed <= 0.75){
	instance_destroy();
}