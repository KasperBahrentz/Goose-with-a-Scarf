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

spd = 0;
top_spd = 11;
acceleration = 1.5;
deceleration = 0.8;

spr_number = 0;

move_dir = 1;

