var interpolated = lerp(grow_height, target, grow_speed);

grow_height = interpolated;

// Clamp between 0 and vp_height just in case
grow_height = clamp(grow_height, 0, vp_height);

grow_speed = lerp(grow_speed, grow_speed_max, 0.01);

if (abs(target-grow_height) <= 2) {
    if (from_top) instance_destroy();
}