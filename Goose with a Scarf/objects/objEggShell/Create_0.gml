/// @description Insert description here
// You can write your code in this editor

image_index = random_range(0, image_number);
image_xscale = choose(1, -1);
image_yscale = choose(1, -1);
speed = random_range(32, 48);

switch(shell_id){
	case "down":	direction = random_range(225, 315);	break;
	case "right":	direction = random_range(135, 225);	break;
	case "left":	direction = random_range(315, 360+45);	break;
}

