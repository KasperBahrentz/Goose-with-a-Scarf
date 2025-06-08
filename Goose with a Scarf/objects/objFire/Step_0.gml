/// @description Insert description here
// You can write your code in this editor

event_inherited();

x += sin(timer)/8;
//image_yscale = 1 + sin(timer)/6;
//image_xscale = 1 - sin(timer)/8;

timer += 0.04;
flicker_phase += 0.01; // Slower phase increment for a gentle flicker