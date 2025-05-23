/// @description Insert description here
// You can write your code in this editor

if (state != player_state.GONE){
	if (sprite_index == spr_body_crouch || sprite_index == spr_body_die){
		draw_self();
	}
	else {
		draw_sprite_custom(objGooseHead.sprite_index);
		draw_self();
		draw_sprite_custom(objGooseFeet.sprite_index);
		if (parasol != noone){
			with (parasol){
				draw_sprite_ext(sprite_index, image_index, other.x, other.y-7*pixel_size, image_xscale, image_yscale, 0, c_white, 1);
			}
		}
	}
}

draw_set_font(fnt_16_bit);

//draw_set_color(c_red);
//draw_rectangle(bbox_left, bbox_top - 10*pixel_size, bbox_right, bbox_bottom + 4*pixel_size, false);
//draw_set_color(c_white);

draw_text(x, y, debug_string);
//draw_text(x, y+64, debug_string);
//if (array_length(follow_queue) >= 0) draw_text(x, y + 32 * pixel_size,  follow_queue[0]);