/// @description Insert description here
// You can write your code in this editor

image_speed = img_speed;
image_alpha = lerp(image_alpha, 1, alpha_speed);
img_speed = lerp(img_speed, 0, 0.05);

if (image_index >= image_number-1){
	image_speed = 0;	
}