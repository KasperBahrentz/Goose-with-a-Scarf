/// @description Insert description here
// You can write your code in this editor

cam = view_camera[0];//Camera by default
follow = objGooseBody;
view_w_half = camera_get_view_width(cam) * 0.5;
view_h_half = camera_get_view_height(cam) * 0.5;

x_to = xstart;
y_to = ystart;

// Screen shake
shake = false;
shake_time = 0;
shake_magnitude = 0;
shake_fade = 0.25;