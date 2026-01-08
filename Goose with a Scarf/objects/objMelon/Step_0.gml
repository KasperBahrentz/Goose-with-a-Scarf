switch (state)
{
    case melon_state.ROLL:
    {
        // -------------------------------------------------
        // Support check (solid tiles + solid instances)
        // -------------------------------------------------
        var _has_support =
            check_collision(0, 1) ||
            place_meeting(x, y + 1, objCollisionSemiSolid);

        // -------------------------------------------------
        // Horizontal speed
        // -------------------------------------------------
        if (_has_support)
        {
            hsp = roll_dir * roll_spd;
        }
        else
        {
            hsp = lerp(hsp, 0, 0.015);
        }

        // -------------------------------------------------
        // Horizontal movement with impact detection
        // -------------------------------------------------
        var _steps = abs(hsp);
        var _dir = sign(hsp);

        repeat (_steps)
        {
            // Crates (special case)
            var _crate = instance_place(x + _dir, y, prtCrate);
            if (_crate != noone && _crate.object_index != objRock && !object_is_ancestor(_crate.object_index, objRock) && crate_timer <= 0)
            {
                with (_crate)
                {
                    hp = 0;
                }
				crate_timer = crate_timer_max;
                break;
            }
			else crate_timer--;
			
            // Solid impact (tiles + solid instances)
	        if (check_collision(_dir, -4*pixel_size, [objCrate, objCrateBig, objCrateStrawberry, objMelonSpawner])) // we check slightly above so the melon will roll over 1-tile holes
	        {
	            state = melon_state.SPLAT;
	            break;
	        }

            x += _dir;
        }

        if (state == melon_state.SPLAT)
        {
            break;
        }

        // -------------------------------------------------
        // Gravity
        // -------------------------------------------------
        if (!_has_support)
        {
            current_fall_spd = min(current_fall_spd + fall_spd, max_fall_spd);

            var _vsteps = abs(current_fall_spd);
            var _vdir = sign(current_fall_spd);

            repeat (_vsteps)
            {
                // Solid tiles + instances
                if (
                    check_collision(0, _vdir) ||
                    place_meeting(x, y + _vdir, objCollisionSemiSolid)
                )
                {
                    current_fall_spd = 0;
                    break;
                }

                y += _vdir;
            }
        }
        else
        {
            current_fall_spd = 0;
			
	        // Resolve ground overlap
	        while (
	            place_meeting(x, y, [objCollisionSemiSolid]) || check_collision(0, 0, [prtCrate, objMelonSpawner])
	        )
	        {
	            y -= 1;
	        }

            if (point_distance(x, y, objGooseBody.x, objGooseBody.y) <= 16 * tile_size)
            {
                audio_sound_gain(snd_inst_thunder, 1, 30);
            }
        }

        // -------------------------------------------------
        // Kill player
        // -------------------------------------------------
        if (place_meeting(x, y, objGooseBody))
        {
            objGooseBody.state = player_state.DIE;
            state = melon_state.SPLAT;
        }

        // -------------------------------------------------
        // Melon–melon collision
        // -------------------------------------------------
        var _other = collision_circle(
            x,
            y,
            sprite_width / 3,
            objMelon,
            false,
            true
        );

        if (_other != noone)
        {
            state = melon_state.SPLAT;
            _other.state = melon_state.SPLAT;
        }

        // -------------------------------------------------
        // Off-screen cleanup
        // -------------------------------------------------
        if (y >= room_height - 8 * pixel_size)
        {
			if (audio_is_playing(snd_inst_thunder)) audio_stop_sound(snd_inst_thunder);
            instance_destroy();
        }

    } break;

    case melon_state.SPLAT:
    {
        audio_stop_sound(snd_inst_thunder);

        repeat (choose(1, 2, 2, 2, 3))
            instance_create_layer(x, y, "instances", objMelonSplat, { splat_id: "down" });

        repeat (choose(1, 2, 2, 2, 3))
            instance_create_layer(x, y, "instances", objMelonSplat, { splat_id: "left" });

        repeat (choose(1, 2, 2, 2, 3))
            instance_create_layer(x, y, "instances", objMelonSplat, { splat_id: "right" });

        if (point_distance(x, y, objGooseBody.x, objGooseBody.y) <= 16 * tile_size)
        {
            audio_sound_pitch(sndSplat, random_range(0.9, 1.1));
            audio_play_sound(sndSplat, 5, false);
            screenshake(10, 2, 0.2);
        }

        instance_destroy();
    } break;
}

if (objGooseBody.state == player_state.GONE){
	instance_destroy();
	audio_stop_sound(snd_inst_thunder);
}