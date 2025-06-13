// Get view size and top-left corner of the camera
var cam = objCam.cam;
var vp_w = camera_get_view_width(cam);
var vp_h = camera_get_view_height(cam);
var cam_x = camera_get_view_x(cam);
var cam_y = camera_get_view_y(cam);

// Compute sprite scale
var spr_w = sprite_get_width(sprite_index);
var spr_h = sprite_get_height(sprite_index);

var scale_x = vp_w / spr_w;
var scale_y = grow_height / spr_h;

// Compute draw position based on `from_top`
var draw_x = cam_x + vp_w * 0.5; // center horizontally
var draw_y;

if (from_top) {
    draw_y = cam_y + grow_height * 0.5; // grow down
} else {
    draw_y = cam_y + vp_h - grow_height * 0.5; // grow up
}


// Draw
draw_sprite_ext(sprite_index, 0, draw_x, draw_y, scale_x, scale_y, 0, c_white, 1);
draw_set_alpha(1);
