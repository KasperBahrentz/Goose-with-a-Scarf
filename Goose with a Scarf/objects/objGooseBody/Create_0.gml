/// @description Insert description here
// You can write your code in this editor

instance_create_layer(x, y, layer, objGooseFeet);
instance_create_layer(x, y, layer, objGooseHead);

spr_body_idle = sprGooseBodyIdle;
spr_body_run = sprGooseBodyRun;

spr_head_idle = sprGooseHeadIdle;

spr_feet_idle = sprGooseFeetIdle;
spr_feet_run = sprGooseFeetRun;

spd = 8;

spr_number = 0;

