/// @description Insert description here
// You can write your code in this editor

if(instance_exists(follow))
{
	if (follow != objBalloon or (follow == objBalloon and objBalloon.state == balloon_state.FLY_UP)){
		x_to=follow.x;
	    y_to=follow.y;
	}
	
	if (instance_exists(objBalloon)){
		if (objBalloon.state == balloon_state.STOP_IN_AIR){
			var _target_pan_y = follow.y - 4*tile_size
			y_to = min(follow.y, lerp(y_to, _target_pan_y, 0.01));
			y_to = max(y_to, _target_pan_y);
		}	
		
		if (abs(objBalloon.vspeed) < 2.5){
			objCloud.speed = lerp(objCloud.speed, objCloud.start_speed*4, 0.1);
			var _target_pan_x = follow.x - 10*tile_size
			x_to = min(follow.x, lerp(x_to, _target_pan_x, 0.01));
			x_to = max(x_to, _target_pan_x); 
		}
	}
}

x += (x_to - x) / 25;
y += (y_to - y) / 25;

//Update camera view
x = clamp(x,view_w_half+tile_size,room_width-view_w_half-tile_size);
y = clamp(y,view_h_half+tile_size,room_height-view_h_half-tile_size);

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

// Parallax Scrolling
layer_x("mountains_front", mountains_front_x + x / 32);
layer_x("mountains_middle", mountains_middle_x + x / 16);
layer_x("mountains_back", mountains_back_x + x / 8);

layer_y("mountains_front", mountains_front_y + y / 16);
layer_y("mountains_middle", mountains_middle_y + y / 32);
layer_y("mountains_back", mountains_back_y + y / 64);