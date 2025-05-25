if (color == flower_color.BLUE){
	instance_create_layer(x, y, "instances", objFlowerPlatformBlue, {leaf_propeller : leaf_propeller});
}
else instance_create_layer(x, y, "instances", objFlowerPlatformRed, {leaf_propeller : leaf_propeller});
instance_destroy();