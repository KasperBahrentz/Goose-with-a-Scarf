/// @description Insert description here
// You can write your code in this editor

display_set_gui_maximise();
draw_set_font(fnt_gui);
draw_sprite(fruit_to_draw, img_index, x - 16*pixel_size, y + 8*pixel_size);
draw_text(x, y, objGame.fruit_collected[index]);