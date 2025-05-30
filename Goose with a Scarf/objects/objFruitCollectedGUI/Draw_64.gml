/// @description Insert description here
// You can write your code in this editor

if (objGooseBody.state != player_state.DIE){
	draw_set_font(fnt_gui);
	draw_sprite(fruit_to_draw, img_index, x - 16*pixel_size, y + 8*pixel_size);
	draw_text(x, y, objGame.number_of_fruit_collected[index]);
}