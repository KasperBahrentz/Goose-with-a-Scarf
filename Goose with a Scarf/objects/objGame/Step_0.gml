/// @description Insert description here
// You can write your code in this editor

draw_set_font(fnt_16_bit);

// Screen shake
if (shake) { 
   shake_time -= 1; 
   var _xval = choose(-shake_magnitude, shake_magnitude); 
   var _yval = choose(-shake_magnitude, shake_magnitude); 
   camera_set_view_pos(view_camera[0], tile_size + _xval, tile_size + _yval); 

   if (shake_time <= 0) { 
      shake_magnitude -= shake_fade; 

      if (shake_magnitude <= 0) { 
         camera_set_view_pos(view_camera[0], tile_size, tile_size); 
         shake = false; 
      } 
   } 
}