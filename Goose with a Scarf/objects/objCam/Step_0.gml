/// @description Insert description here
// You can write your code in this editor

if(instance_exists(follow))
{
    x_to=follow.x;
    y_to=follow.y;
}

x += (x_to - x) / 25;
y += (y_to - y) / 25;

//Update camera view
x = clamp(x,view_w_half+objGame.tile_size,room_width-view_w_half-objGame.tile_size);
y = clamp(y,view_h_half+objGame.tile_size,room_height-view_h_half-objGame.tile_size);

// Screen shake
if (shake) {
   shake_time -= 1; 
   var _xval = choose(-shake_magnitude, shake_magnitude); 
   var _yval = choose(-shake_magnitude, shake_magnitude); 
   x += _xval;
   y += _yval;

   if (shake_time <= 0) { 
      shake_magnitude -= shake_fade; 

      if (shake_magnitude <= 0) { 
         shake = false; 
      } 
   } 
}

camera_set_view_pos(cam,x-view_w_half,y-view_h_half);