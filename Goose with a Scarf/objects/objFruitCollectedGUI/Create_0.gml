/// @description Insert description here
// You can write your code in this editor

enum gui_state {
	MOVE_IN,
	STAY,
	MOVE_OUT
}

state = gui_state.MOVE_IN;

fruit_to_draw = fruit.sprite_index;
index = fruit.fruit_index;
img_index = fruit.image_number-1;

cam = objCam.cam;

start_x = camera_get_view_x(cam) + camera_get_view_width(cam) + 32 * pixel_size;

// y is fixed relative to top of GUI
y = 32 * pixel_size + 16 * pixel_size * (instance_number(objFruitCollectedGUI) - 1);

x = start_x;

depth -= 1000;