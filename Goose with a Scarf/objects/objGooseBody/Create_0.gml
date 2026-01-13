/// @description Insert description here
// You can write your code in this editor
enum player_state{
	MOVE,
	DIE,	
	GONE,
	SIT,
}

enum flower_color {
	RED,
	BLUE
}

if (!instance_exists(objGame)){
	instance_create_layer(x, y, "instances", objGame);	
}

if (!instance_exists(objCam)){
	instance_create_layer(x, y, "instances", objCam);	
}

if (objGame.exited_house){
	objGame.exited_house = false;
	x = objGame.door_x;
	y = objGame.door_y;
	objCam.x = x;
	objCam.y = y;
}

if (audio_is_playing(sndThunder)) audio_stop_sound(sndThunder);

hspeed_tracker = 0;

keys = [];

lay = false;

depth -= 5;

instance_create_layer(x, y, layer, objGooseFeet);
instance_create_layer(x, y, layer, objGooseHead);

idle_timer_max = 400;
idle_timer = idle_timer_max;
feet_dance_timer_max = 110;
feet_dance_timer = feet_dance_timer_max;
dance_cycles = 0;

// Create Event of objGooseBody
_blend_amount = 0; // 0 = white, 1 = deep space blue

is_on_ground = false;
active_flower = flower_color.RED;

parasol = noone;

grav = 18;
glide_timer_max = 60;
glide_timer = 0;

debug_string = 0;
debug_x = 0;
debug_y = 0;

water_timer_max = 5;
water_timer = water_timer_max;


follow_queue = [];
egg_queue = []

was_in_air = false;

for (var i = 1; i <= egg_count; i++){
	instance_create_layer(objGooseBody.x, objGooseBody.y, "instances", objEgg, {state : egg_state.MOVE});
}

was_on_ground_timer_max = 4;
was_on_ground_timer = 0;

sound_timer_max = 60;
sound_timer = 0;

state = player_state.MOVE;

spr_body_idle = sprGooseBodyIdle;
spr_body_run = sprGooseBodyRun;
spr_body_glide = sprGooseBodyGlide;

spr_body_crouch = sprGooseCrouch;
spr_body_die = sprGooseDie;
spr_body_sit = sprGooseBodySit;

spr_head_idle = sprGooseHeadIdle;
spr_head_honk = sprGooseHeadHonk;

spr_feet_idle = sprGooseFeetIdle;
spr_feet_run = sprGooseFeetRun;
spr_feet_jump = sprGooseFeetJump;
spr_feet_sit = sprGooseFeetSit;

move_dir = dir.RIGHT;

h_spd = 0;
h_top_spd = 12;
acceleration = 1.8;
deceleration = 0.8;

jump_height = 44;
v_deceleration = 0.5;
max_jump_timer = 20;
egg_drop_max_jump_timer = 30;
jump_timer = max_jump_timer;

current_max_jump_timer = max_jump_timer;

spr_number = 0;

move_dir = 1;

spr_bbox_left = sprite_get_bbox_left(sprite_index) - sprite_get_xoffset(sprite_index);
spr_bbox_right = sprite_get_bbox_right(sprite_index) - sprite_get_xoffset(sprite_index);
spr_bbox_top = sprite_get_bbox_top(sprite_index) - sprite_get_yoffset(sprite_index);
spr_bbox_bottom = sprite_get_bbox_bottom(sprite_index) - sprite_get_yoffset(sprite_index);

map_x = 0;
map_y = 0;

function honk(){
	audio_sound_pitch(sndHonk, random_range(0.9, 1.1));
	audio_play_sound(sndHonk, 10, false);
	objGooseHead.sprite_index = spr_head_honk;
	if (sprite_index == spr_body_crouch){
		image_index = 1;
	}
}

var _has_water_front = layer_has_tiles("water_front");
var _has_water_back = layer_has_tiles("water_back");
var _has_water_windows = layer_has_tiles("water_windows");

// Play water sound if water is in room
if (_has_water_front or _has_water_back or _has_water_windows){
	if (!audio_is_playing(sndRunningWater)) audio_play_sound(sndRunningWater, 3, true);	
	if (_has_water_front) cover_all_water_tiles("water_front");
	if (_has_water_back) cover_all_water_tiles("water_back");
	if (_has_water_windows) cover_all_water_tiles("water_windows");
}
else audio_stop_sound(sndRunningWater);

if (!instance_exists(objBalloon)){
	audio_play_sound(sndHonk, 10, false);
}