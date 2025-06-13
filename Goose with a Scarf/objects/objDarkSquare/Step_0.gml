var vp_height = camera_get_view_height(view_camera[0]);

var target = vp_height;
var interpolated = lerp(grow_height, target, 0.05);
var min_step = 2 * pixel_size;

if (interpolated - grow_height < min_step) {
    grow_height += min_step;
} else {
    grow_height = interpolated;
}

grow_height = min(grow_height, vp_height);
