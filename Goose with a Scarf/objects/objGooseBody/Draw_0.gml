/// @description Insert description here
// You can write your code in this editor

if (sprite_index == spr_body_crouch){
	draw_self();
}
else {
	draw_sprite_custom(objGooseHead.sprite_index);
	draw_self();
	draw_sprite_custom(objGooseFeet.sprite_index);
}

//draw_set_color(c_red);
//draw_rectangle(bbox_left, bbox_top - 10*objGame.pixel_size, bbox_right, bbox_bottom + 4*objGame.pixel_size, false);
//draw_set_color(c_white);


//draw_text(x, y, egg_queue);
//draw_text(x, y+64, debug_string);
//if (array_length(follow_queue) >= 0) draw_text(x, y + 32 * objGame.pixel_size,  follow_queue[0]);