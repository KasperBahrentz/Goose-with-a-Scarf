/// @description Insert description here
// You can write your code in this editor

vp_height = camera_get_view_height(view_camera[0]);
grow_speed = 0.02;
grow_speed_max = 0.15;

if (from_top){
	grow_height = vp_height;
	target = 0;
}
else {
	grow_height = 0;
	target = vp_height;
}


depth = -10000;