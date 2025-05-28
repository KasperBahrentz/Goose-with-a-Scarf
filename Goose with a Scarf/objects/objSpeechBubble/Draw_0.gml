gpu_set_tex_filter(true);

if (string_length(text_shown) >= 1) {
    // Remove formatting markers (~) for measurement only
    var text_plain = "";
    var in_tag = false;
    var len = string_length(text_shown);

    for (var i = 1; i <= len; i++) {
        var ch = string_char_at(text_shown, i);
        if (ch == "~") {
            // Toggle formatting marker, don't add to string
            in_tag = !in_tag;
        } else {
            text_plain += ch;
        }
    }

    // GUI-space margins
    var _space_between_lines = 10 * pixel_size;
    var _max_line_width = 100 * pixel_size;

    var text_w = string_width_ext(text_plain, _space_between_lines, _max_line_width);
    var text_h = string_height_ext(text_plain, _space_between_lines, _max_line_width);

    // These are GUI-space sizes; convert them to world-space
    var gui_bubble_w = (text_w + text_margin * 2);
    bubble_h = (text_h + text_margin * 2 + 24);

    var bubble_w_world = gui_bubble_w / (display_get_gui_width() / camera_get_view_width(view_camera[0]));
    var bubble_h_world = bubble_h / (display_get_gui_height() / camera_get_view_height(view_camera[0]));

    var _view_x = camera_get_view_x(view_camera[0]);
    var _view_y = camera_get_view_y(view_camera[0]);
    var _view_w = camera_get_view_width(view_camera[0]);
    var _view_h = camera_get_view_height(view_camera[0]);

    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();

    draw_x = ((x - _view_x) / _view_w) * _gui_w;
    draw_y = ((y - _view_y) / _view_h) * _gui_h;

    draw_sprite_ext(
        sprite_index, image_index,
        x, y,
        bubble_w_world / sprite_get_width(sprite_index),
        bubble_h_world / sprite_get_height(sprite_index),
        0, c_white, 1
    );
}

gpu_set_tex_filter(false);
