/// @description Insert description here
// You can write your code in this editor

image_index = random_range(0, image_number);
image_xscale = choose(1, -1);
image_yscale = choose(1, -1);
initial_speed = random_range(24, 48);
speed = initial_speed

switch(shell_id){
	case "down":	direction = random_range(225, 315);	break;
	case "left":	direction = random_range(135, 225);	break;
	case "right":	direction = random_range(315, 360+45);	break;
}

switch(color){
	case "pink":	sprite_index = sprEggShellPink;		break;
	case "orange":	sprite_index = sprEggShellOrange;	break;
	case "green":	sprite_index = sprEggShellGreen;	break;
}

