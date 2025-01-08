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

h_spd = 0;
top_spd = 11;
acceleration = 1.5;
deceleration = 0.8;

v_spd = 0;
grav = 16;
jump_height = 10;

spr_number = 0;

move_dir = 1;

spr_bbox_left = sprite_get_bbox_left(sprite_index) - sprite_get_xoffset(sprite_index);
spr_bbox_right = sprite_get_bbox_right(sprite_index) - sprite_get_xoffset(sprite_index);
spr_bbox_top = sprite_get_bbox_top(sprite_index) - sprite_get_yoffset(sprite_index);
spr_bbox_bottom = sprite_get_bbox_bottom(sprite_index) - sprite_get_yoffset(sprite_index);

map_x = 0;
map_y = 0;

tilesize = 128;
