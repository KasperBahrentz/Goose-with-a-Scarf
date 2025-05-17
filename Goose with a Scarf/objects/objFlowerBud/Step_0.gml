/// @description Insert description here
// You can write your code in this editor

if (objGooseBody.active_flower == color){
	if (color == flower_color.BLUE){
		instance_create_layer(x, y, "instances", objFlowerPlatformBlue, {leaf_propeller : leaf_propeller});
	}
	else instance_create_layer(x, y, "instances", objFlowerPlatformRed, {leaf_propeller : leaf_propeller});
	instance_destroy();
}