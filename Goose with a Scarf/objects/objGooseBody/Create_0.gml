/// @description Insert description here
// You can write your code in this editor

instance_create_layer(x, y, layer, objGooseFeet);
instance_create_layer(x, y, layer, objGooseHead);

enum player_state{
	MOVE,
	PAUSE	
}

debug_string = 0;

// Play water sound
audio_play_sound(sndRunningWater, 3, true);

follow_queue = [];
egg_queue = []

was_in_air = false;

egg_count = 3;

for (var i = 1; i <= egg_count; i++){
	instance_create_layer(objGooseBody.x, objGooseBody.y, "instances", objEgg, {egg_id : i})
}

grass_timer_max = 60;
grass_timer = 0;

state = player_state.MOVE;

spr_body_idle = sprGooseBodyIdle;
spr_body_run = sprGooseBodyRun;
spr_body_crouch = sprGooseCrouch;

spr_head_idle = sprGooseHeadIdle;
spr_head_honk = sprGooseHeadHonk;

spr_feet_idle = sprGooseFeetIdle;
spr_feet_run = sprGooseFeetRun;
spr_feet_jump = sprGooseFeetJump;

move_dir = dir.RIGHT;

h_spd = 0;
h_top_spd = 12;
acceleration = 1.8;
deceleration = 0.8;

jump_height = 44;
v_deceleration = 0.5;
grav = 18;
max_jump_timer = 20;
egg_drop_max_jump_timer = 30;
jump_timer = max_jump_timer;

current_max_jump_timer = 0;

spr_number = 0;

move_dir = 1;

spr_bbox_left = sprite_get_bbox_left(sprite_index) - sprite_get_xoffset(sprite_index);
spr_bbox_right = sprite_get_bbox_right(sprite_index) - sprite_get_xoffset(sprite_index);
spr_bbox_top = sprite_get_bbox_top(sprite_index) - sprite_get_yoffset(sprite_index);
spr_bbox_bottom = sprite_get_bbox_bottom(sprite_index) - sprite_get_yoffset(sprite_index);

map_x = 0;
map_y = 0;

has_jumped = false;