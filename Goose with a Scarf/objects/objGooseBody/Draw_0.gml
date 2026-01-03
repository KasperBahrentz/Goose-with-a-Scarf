var deep_space_blue = make_colour_rgb(10, 12, 25);

var _target_blend = 0;
if ((!is_on_tilemap(objGame.back_tilemap, y - 1 * pixel_size)) and (place_meeting(x, y, objMoon))){
	_target_blend = 1;
}

// Smoothly approach target blend
_blend_amount = lerp(_blend_amount, _target_blend, 0.25); // adjust 0.25 for speed

var _blend_col = merge_color(c_white, deep_space_blue, _blend_amount);
image_blend = _blend_col;
draw_goose();



function draw_goose(){
	if (state != player_state.GONE){
		if (sprite_index == spr_body_crouch || sprite_index == spr_body_die){
			draw_self();
		}
		else if (sprite_index == spr_body_sit){
			draw_self();
			draw_sprite_custom(objGooseFeet.sprite_index, objGooseFeet.image_index, x, y);
		}
		else {
			draw_sprite_custom(objGooseHead.sprite_index, image_index, x, y);
			draw_self();
			draw_sprite_custom(objGooseFeet.sprite_index, image_index, x, y);
			if (parasol != noone){
				with (parasol){
					draw_sprite_ext(sprite_index, image_index, other.x, other.y-7*pixel_size, image_xscale, image_yscale, 0, image_blend, 1);
				}
			}
		}
	}
}

var tile_id = tilemap_get_at_pixel(layer_tilemap_get_id("ground"), x, y + 10);

draw_set_font(fnt_smooth);


/// draw_event (debug)


// draw triangle collisions
//var _tilemap = objGame.collision_tilemap;
//var _tile_w = tile_size;
//var _tile_h = tile_size;

//// Visible area (performance-safe)
//var _left   = floor(camera_get_view_x(view_camera[0]) / _tile_w) * _tile_w;
//var _top    = floor(camera_get_view_y(view_camera[0]) / _tile_h) * _tile_h;
//var _right  = _left + camera_get_view_width(view_camera[0]);
//var _bottom = _top  + camera_get_view_height(view_camera[0]);

//draw_set_alpha(0.4);

//for (var yy = _top; yy < _bottom; yy += _tile_h)
//{
//    for (var xx = _left; xx < _right; xx += _tile_w)
//    {
//        var _tile_id = tilemap_get_at_pixel(_tilemap, xx + 1, yy + 1);

//        if (_tile_id == top_right_triangle_id)
//        {
//            draw_set_colour(c_red);

//				draw_triangle(
//				    xx, yy,                     // top-left
//				    xx + _tile_w, yy,           // top-right
//				    xx + _tile_w, yy + _tile_h, // bottom-right
//				    false
//				);

//        }
//        else if (_tile_id == top_left_triangle_id)
//        {
//            draw_set_colour(c_blue);

//			draw_triangle(
//			    xx, yy,                     // top-left
//			    xx + _tile_w, yy,           // top-right
//			    xx, yy + _tile_h,           // bottom-left
//			    false
//			);
//        }
//    }
//}

draw_set_alpha(1);
draw_set_colour(c_white);


//draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false);


//draw_text(x, y, tile_id);
//draw_text(objBalloon.x, objBalloon.y + tile_size, objBalloon.pan_camera);

//draw_text(x, y, is_on_ground);
//draw_set_color(c_red);
//draw_rectangle(bbox_left, bbox_top - 10*pixel_size, bbox_right, bbox_bottom + 4*pixel_size, false);
//draw_set_color(c_white);


//draw_text(x, y+64, debug_string);
//if (array_length(follow_queue) >= 0) draw_text(x, y + 32 * pixel_size,  follow_queue[0]);