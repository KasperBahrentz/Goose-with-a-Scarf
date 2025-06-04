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
			draw_sprite_custom(objGooseFeet.sprite_index, objGooseFeet.image_index);
		}
		else {
			draw_sprite_custom(objGooseHead.sprite_index, image_index);
			draw_self();
			draw_sprite_custom(objGooseFeet.sprite_index, image_index);
			if (parasol != noone){
				with (parasol){
					draw_sprite_ext(sprite_index, image_index, other.x, other.y-7*pixel_size, image_xscale, image_yscale, 0, c_white, 1);
				}
			}
		}
	}
}

draw_set_font(fnt_smooth);

//draw_text(x, y, array_length(objGame.found_hidden_blocks));
//draw_set_color(c_red);
//draw_rectangle(bbox_left, bbox_top - 10*pixel_size, bbox_right, bbox_bottom + 4*pixel_size, false);
//draw_set_color(c_white);


//draw_text(x, y+64, debug_string);
//if (array_length(follow_queue) >= 0) draw_text(x, y + 32 * pixel_size,  follow_queue[0]);