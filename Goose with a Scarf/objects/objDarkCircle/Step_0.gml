/// @description Insert description here
// You can write your code in this editor

image_speed = img_speed;
img_speed = lerp(img_speed, 0, 0.05);

image_alpha = (image_index / (image_number-1));

if (image_index >= image_number-1){
	image_speed = 0;	
}