draw_self(); // Draw the object itself

var _bbox_left   = bbox_left;
var _bbox_right  = bbox_right;
var _bbox_top    = bbox_top;
var _bbox_bottom = bbox_bottom;

var _room_width  = room_width;
var _room_height = room_height;

draw_set_color(c_black);
draw_set_alpha(image_alpha);

// Left box (from room edge to left of bounding box)
if (_bbox_left > 0) {
    draw_rectangle(0, 0, _bbox_left, _room_height, false);
}

// Right box (from right of bounding box to room edge)
if (_bbox_right < _room_width) {
    draw_rectangle(_bbox_right, 0, _room_width, _room_height, false);
}

// Top box (between left/right bbox edges, from top to top of bbox)
if (_bbox_top > 0) {
    draw_rectangle(_bbox_left, 0, _bbox_right, _bbox_top, false);
}

// Bottom box (between left/right bbox edges, from bottom of bbox to room bottom)
if (_bbox_bottom < _room_height) {
    draw_rectangle(_bbox_left, _bbox_bottom, _bbox_right, _room_height, false);
}

draw_set_alpha(1); // Reset alpha
draw_set_color(c_white);
