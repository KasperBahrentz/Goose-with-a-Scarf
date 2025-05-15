/// @description Insert description here
// You can write your code in this editor


switch(color){
	case "pink":	sprite_index = sprEggShellPink;		break;
	case "orange": 	sprite_index = sprEggShellOrange;	break;
	case "green": 	sprite_index = sprEggShellGreen;	break;
}


image_index = random_range(0, image_number);
image_xscale = choose(1, -1);
image_yscale = choose(1, -1);
initial_speed = random_range(24, 48);
speed = initial_speed;

set_direction(shell_id);

direction = random_range(0, 360);