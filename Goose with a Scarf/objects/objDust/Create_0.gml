/// @description Insert description here
// You can write your code in this editor

image_index = random_range(0, 2);
image_xscale = choose(1, -1);
image_yscale = choose(1, -1);
speed = random_range(4, 8);

depth -= 10;

switch(dust_id){	
	case "down":	direction = random_range(225, 315);		speed = random_range(2, 4);		break;
	case "left":	direction = random_range(145, 225);										break;
	case "right":	direction = random_range(315, 360+35);									break;
}
