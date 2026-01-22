// @description Insert description here
// You can write your code in this editor

switch (state){
	case player_state.MOVE:			move();			break;
	case player_state.DIE:			die();			break;	
	case player_state.GONE:			gone();			break;
	case player_state.SIT:			sit();			break;
	case player_state.ENTER_DOOR:	enter_door();	break;
}

function enter_door() {
	sprite_index = spr_body_enter_door;
}

function sit(){
	if (lay == false){ // Do the little feet dance
		sprite_index = spr_body_sit;
		objGooseFeet.sprite_index = spr_feet_sit;
		if (feet_dance_timer <= 0){
			if (dance_cycles <= 0){
				if (alarm[3] == -1) dance_cycles = irandom_range(2, 6);
				else if (alarm[3] >= 300) dance_cycles = irandom_range(2, alarm[3]/100);
			}
						
			if (dance_cycles > 0) objGooseFeet.image_speed = 1;
			else {
				objGooseFeet.image_speed = 0;
				objGooseFeet.image_index = 0;
			}
			if (objGooseFeet.image_index >= objGooseFeet.image_number){
				objGooseFeet.image_index = 1;
				dance_cycles--;
			
				if (dance_cycles <= 0){
					objGooseFeet.image_speed = 0;
					objGooseFeet.image_index = 0;
					feet_dance_timer = feet_dance_timer_max + irandom_range(0, feet_dance_timer_max);
				}
			}
		}
		else {
			feet_dance_timer--;
		}
				
		// Sit on bench
		if (instance_exists(objBench)){
			var _bench = instance_nearest(x, y, objBench);
			if (distance_to_object(_bench) <= 1*pixel_size){
				y = _bench.y -8*pixel_size;
				image_xscale = -_bench.image_xscale;	
				objBenchHandle.depth = depth - 20;
			}
		}
	}
	else sprite_index = spr_body_crouch;
	
	if (idle_timer <= 0){
		alarm[3] = idle_timer_max*2 + irandom_range(0, idle_timer_max);
		idle_timer = idle_timer_max + irandom_range(0, idle_timer_max/3);
	}
	hspeed = 0;
	vspeed = 0;
	if (keyboard_check_pressed(ord("H")) or keyboard_check_pressed(ord("A")) or keyboard_check_pressed(ord("S")) or keyboard_check_pressed(ord("D")) or keyboard_check_pressed(vk_space)){
		alarm[3] = 1;
	}
}

function gone(){
	hspeed = 0;
	vspeed = 0;
}

function die(){
	if (alarm[2] <= 0){
		audio_sound_pitch(sndHonk, 1.3);
		audio_play_sound(sndHonk,10, false);
		alarm[2] = 60;
		hspeed = 0;
		vspeed = 0;
		sprite_index = spr_body_die;
		instance_create_layer(x, y, "instances", objDarkCircle);
	}
}

function set_sit(_force_sit = false){
	feet_dance_timer = feet_dance_timer_max + irandom_range(0, feet_dance_timer_max);	
	dance_cycles = irandom_range(2, 4);
	objGooseFeet.image_speed = 0;
	objGooseFeet.image_index = 0;
	
	var _choose = random_range(0, 1);
	
	if (_choose >= 0.1 or _force_sit){
		lay = false;
	}
	else {
		lay = true;
	}
	
	state = player_state.SIT;	
}

function move(){
	image_speed = 1;
	if (hspeed_tracker == 0 and is_on_ground and !keyboard_check_pressed(ord("S"))){
		if (idle_timer <= 0){
			set_sit();
		}
		idle_timer--;	
	}
	else {
		idle_timer = idle_timer_max + irandom_range(0, idle_timer_max/3);	
	}
	
	// Sit on bench
	if (distance_to_object(objBench) <= 1*pixel_size and is_on_ground == true and keyboard_check_pressed(ord("W"))){
		set_sit(true);
	}
	
	if (y > room_height){
		state = player_state.DIE;
	}
	
	// Screen shake test
	if (keyboard_check_pressed(ord("M"))){
		screenshake(30, 10, 0.3);	
	}
	
	if (!audio_is_playing(sndHonk)){
		objGooseHead.sprite_index = spr_head_idle;
		if (sprite_index == spr_body_crouch) image_index = 0;
	}
	
	// Move horizontally
	var _key_right = keyboard_check(ord("D"));
	var _key_left = keyboard_check(ord("A"));
	var _moving = (_key_right - _key_left) != 0;
	
	// Provide correct positions to the array of any given egg
	for (var i = 0; i < instance_number(objEgg); i++){
		var _inst = instance_find(objEgg, i);
		with(_inst){
			if (_inst.state = egg_state.MOVE) array_insert(my_queue, 0, [other.x - other.image_xscale*pixel_size, other.y]);
		}
	}
	
	if (_key_right){
		image_xscale = 1;
		move_dir = dir.RIGHT;	
	}
	else if (_key_left){
		image_xscale = -1;
		move_dir = dir.LEFT;	
	}
	
	if (move_dir != sign(hspeed_tracker)){
		h_spd = 0;	
	}
	
	var _top_spd = h_top_spd;
	if (sprite_index == spr_body_crouch) _top_spd = h_top_spd / 2;
	
	if (_moving){ // Accelerate
		h_spd = min(max(deceleration, h_spd*acceleration), _top_spd);
		
		if (is_on_ground){
			if (sound_timer == 0){
				var _play_sound = random_range(0, 1);
		
				if (_play_sound >= 0.9){	
					play_material_sound(get_material());
					sound_timer = sound_timer_max;
				}
			} else {
				sound_timer--;
			}
		}
	}
	else { // Decelerate
		if (h_spd > 1) h_spd = max(0, h_spd*deceleration);
		else h_spd = 0;
	}
	
	var _tilemap = objGame.collision_tilemap;
	
	// Horizontal movement with pixel precision to avoid clipping
	var _steps = abs(h_spd * move_dir);
	var _dir = sign(h_spd * move_dir);
	for (var i = 0; i < _steps; i++) {
		if (check_collision(_dir, 0) || place_meeting(x + _dir, y, objCollision)){
		    // Blocked by either tile or object
		    // Handle collision response
		    if (_dir > 0) {
		        while (check_collision(2, 0) || place_meeting(x + 2, y, objCollision)) x -= 2;	// bbox_right is exclusive; bbox_left is inclusive, therefore, we use 2 here
		    } else {
		        while (check_collision(-1, 0) || place_meeting(x - 1, y, objCollision)) x += 1;
		    }
		    h_spd = 0;
		    break;
		} else {
		    // Free to move
		    x += _dir;
		}
	}
	hspeed_tracker = h_spd * move_dir
	
	jump();
	
	// Move vertically
	var _landed_on_semi_solid = false;
	var _nearly_on_ground = false;
		
	// Semi-solid platforms
	if (vspeed > 0) and (place_meeting(x , y + 4*pixel_size, objCollisionSemiSolid)){
		_landed_on_semi_solid = true;
		_nearly_on_ground = true;
	}
	else if (vspeed > 0) and (place_meeting(x , y + 8*pixel_size, objCollisionSemiSolid)){
		_nearly_on_ground = true;
	}
	
	var _ceiling_hit = vspeed < 0 and check_collision(0, -8*pixel_size);
	
	if (!_nearly_on_ground && (vspeed > 0 && check_collision(0, 8*pixel_size))) _nearly_on_ground = true;
	
		/// Detect ride crate
	var ride_crate = instance_place(x, y + 4*pixel_size, prtCrate);
	var _landed_on_crate = ride_crate != noone;

	if (_landed_on_crate)
	{
	    y = ride_crate.bbox_top - 2*pixel_size;
		_nearly_on_ground = true
		
		if (was_in_air) handle_land_on_ground();
	}

	if (_nearly_on_ground) {
		with(objEgg){
			if (temporary && array_length(spawn_coordinate) == 0){ // if egg is melon egg
				destroy_egg();
				with (other) array_shift(egg_queue);
			}
		}
		current_max_jump_timer = max_jump_timer;
		is_on_ground = true;
		was_on_ground_timer = was_on_ground_timer_max;
		
		// If just landed
		if (was_in_air){
			handle_land_on_ground();
		}
	}
	else {
		is_on_ground = false;	
	}
	
	if (!_landed_on_crate) && ((_landed_on_semi_solid) or (vspeed > 0 and check_collision(0, 4*pixel_size))){ // Stop on ground
		if (_landed_on_semi_solid) _tilemap = layer_tilemap_get_id("back");
		map_y = tilemap_get_cell_y_at_pixel(_tilemap, x, y + 4*pixel_size);
		vspeed = 0;
		y = (map_y * tile_size);
	} 
	
	if (_ceiling_hit){ // Stop at ceiling
		map_y = tilemap_get_cell_y_at_pixel(objGame.collision_tilemap, x, y-8*pixel_size) + 1;
		jump_timer = max(jump_timer, current_max_jump_timer/2 + current_max_jump_timer/4);
		vspeed = floor(max(vspeed - jump_height * (1 - jump_timer/current_max_jump_timer), 0));
		y = (map_y * tile_size) + pixel_size;
	}
	
	// Jump
	if (was_on_ground_timer > 0) and (keyboard_check_pressed(vk_space)) and (sprite_index != spr_body_crouch){
		glide_timer = glide_timer_max;
		jump_timer = 0;
		current_max_jump_timer = max_jump_timer;
		spawn_material_particle();
			
		play_material_sound(get_material());
			
		// Honk at random
		var _number = random_range(0, 1);
		if (_number >= 0.9) honk();
		
		was_on_ground_timer = 0;
	} else // egg drop
	if (array_length(egg_queue) >= 1) and (keyboard_check_pressed(vk_space)) and (vspeed != 0){	
		glide_timer = glide_timer_max;
		instance_create_layer(x, y, "instances", objWoosh);
		jump_timer = 0;
		current_max_jump_timer = egg_drop_max_jump_timer;
		screenshake(15, 3, 0.3);
		var _egg_id = array_shift(egg_queue);
		with(objEgg){
			repeat(6*index){
				array_pop(my_queue);
			}
		}
		
		for (var i = 0; i < instance_number(objEgg); i++){
			var _inst = instance_find(objEgg, i);
			if (_inst.egg_id == _egg_id){
				with(_inst){
					x = other.x;
					y = other.y;
					state = egg_state.DROP;
				}
			}
		}
		
		// Flower platforms
		if (instance_exists(objFlowerPlatform) or instance_exists(objFlowerBud)){
			var _nearest_flower = instance_nearest(x, y, objFlowerPlatform);
			if (_nearest_flower != noone) and (point_distance(x, y, _nearest_flower.x, _nearest_flower.y) <= 14*tile_size){
				_sound = sndPoof;
				audio_sound_pitch(_sound, random_range(0.9, 1.1));
				audio_play_sound(_sound, 1.8, false);
			}
			if (active_flower = flower_color.RED){
				active_flower = flower_color.BLUE;	
				with(objFlowerPlatform){
					if (color == flower_color.RED) state = flower_state.BUD;
				}
			}
			else {
				active_flower = flower_color.RED;	
				with(objFlowerPlatform){
					if (color == flower_color.BLUE) state = flower_state.BUD;
				}
			}
		}
		
		// Play woosh sound
		audio_sound_pitch(sndWoosh, random_range(1, 1.2));
		audio_play_sound(sndWoosh, 5, false);
		
		// Honk at random
		var _number = random_range(0, 1);
		if (_number >= 0.8) honk();
	}
	
	// If in air
	if (!is_on_ground){
		was_in_air = true;
		if (keyboard_check(ord("S"))){
			vspeed += floor((grav/2));
		}
		
		was_on_ground_timer--;		
		
		// Gliding
		if (keyboard_check(vk_space) and glide_timer > 0){
			if (vspeed >= grav){
				vspeed -= floor(grav*0.8);
				if (parasol == noone) glide_timer--;
				sprite_index = spr_body_glide;
			}
			else {
				vspeed -= floor(grav/2);
			}
		}
		else {
			sprite_index = spr_body_idle;
			if (keyboard_check_released(vk_space) && parasol == noone){
				glide_timer = 0;	
			}
		}
	}
	else {		
		// Crouch
		if (keyboard_check(ord("S"))){
			sprite_index = spr_body_crouch;
		}
		else if (keyboard_check_released(ord("S"))){
			sprite_index = spr_body_idle;
		}
	}

	if (sprite_index != spr_body_crouch){
		if (hspeed_tracker != 0) and (is_on_ground){ // Change to running sprite
			if (image_index <= 1) sprite_index = spr_body_run;
			objGooseFeet.sprite_index = spr_feet_run;
		}
		else if (vspeed < 0 or glide_timer > 0) {
			objGooseFeet.sprite_index = spr_feet_jump;	
		}
		else { // Change to idle sprite
			if (image_index <= 1) sprite_index = spr_body_idle;
			objGooseFeet.sprite_index = spr_feet_idle;
		}
	}
}

function handle_land_on_ground(){
	play_material_sound(get_material());
	spawn_material_particle();
	was_in_air = false;
	with(objEggRespawn) alarm[0] = 1;
	glide_timer = 0;
}

function jump(){
	vspeed = grav;
	if (jump_timer < current_max_jump_timer){
		vspeed -= floor(jump_height * (1 - jump_timer/current_max_jump_timer));
		jump_timer++;	
	} else jump_timer = current_max_jump_timer;	
}


if (water_timer >= water_timer_max){ // Change how often to check for distance to water and hidden blocks
	change_water_audio_level(distance_to_object(objWaterDetection));
	water_timer = 0;
}
else water_timer++;

function change_water_audio_level(_dist_to_water){
	var _gain = min(max(0.6, 500/_dist_to_water), 1.2);
	audio_sound_gain(sndRunningWater, _gain, 0);
}