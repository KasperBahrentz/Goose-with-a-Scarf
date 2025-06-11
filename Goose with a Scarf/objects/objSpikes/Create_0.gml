/// @description Insert description here
// You can write your code in this editor

if (image_angle != 0){
	image_index = 1;	
}

if (image_angle == 180){
	switch(sprite_index){
		case sprSpikes:			sprite_index = sprSpikesCeiling;		break;
		case sprSpikesLeft:		sprite_index = sprSpikesLeftCeiling;	break;
		case sprSpikesRight:	sprite_index = sprSpikesRightCeiling;	break;
	}
}