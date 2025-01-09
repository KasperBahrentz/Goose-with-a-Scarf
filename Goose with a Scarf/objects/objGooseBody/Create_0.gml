/// @description Insert description here
// You can write your code in this editor

instance_create_layer(x, y, layer, objGooseFeet);
instance_create_layer(x, y, layer, objGooseHead);

enum player_state{
	MOVE,
	PAUSE	
}

state = player_state.MOVE;

spr_body_idle = sprGooseBodyIdle;
spr_body_run = sprGooseBodyRun;

spr_head_idle = sprGooseHeadIdle;

spr_feet_idle = sprGooseFeetIdle;
spr_feet_run = sprGooseFeetRun;

move_dir = dir.RIGHT;

h_spd = 0;
h_top_spd = 12;
acceleration = 1.8;
deceleration = 0.8;

jump_height = 44;
v_deceleration = 0.5;
grav = 18;
max_jump_timer = 20;
jump_timer = max_jump_timer;

spr_number = 0;

move_dir = 1;

spr_bbox_left = sprite_get_bbox_left(sprite_index) - sprite_get_xoffset(sprite_index);
spr_bbox_right = sprite_get_bbox_right(sprite_index) - sprite_get_xoffset(sprite_index);
spr_bbox_top = sprite_get_bbox_top(sprite_index) - sprite_get_yoffset(sprite_index);
spr_bbox_bottom = sprite_get_bbox_bottom(sprite_index) - sprite_get_yoffset(sprite_index);

map_x = 0;
map_y = 0;

tile_size = 128;
pixel_size = 8;

has_jumped = false;