var text_x = draw_x + text_margin;
var text_y = draw_y - bubble_h + 30;

var cursor_x = text_x;
var cursor_y = text_y;

var red_col = make_color_rgb(215, 45, 45);
var current_col = c_white;
var in_red = false;
var line_spacing = space_between_lines;
var wrap_width = max_line_width;

var i = 1;
var word = "";

draw_set_alpha(image_alpha);

while (i <= string_length(text_shown)) {
    var ch = string_char_at(text_shown, i);

    if (ch == "~") {
        // Draw any pending word
        if (word != "") {
            var word_w = string_width(word);
            if (cursor_x + word_w > text_x + wrap_width) {
                cursor_x = text_x;
                cursor_y += line_spacing;
            }
            draw_set_colour(current_col);
            draw_text(cursor_x, cursor_y, word);
            cursor_x += word_w;
            word = "";
        }

        in_red = !in_red;
        current_col = in_red ? red_col : c_white;
    }
    else if (ch == " ") {
        // Draw the word before the space
        if (word != "") {
            var word_w = string_width(word);
            if (cursor_x + word_w > text_x + wrap_width) {
                cursor_x = text_x;
                cursor_y += line_spacing;
            }
            draw_set_colour(current_col);
            draw_text(cursor_x, cursor_y, word);
            cursor_x += word_w;
            word = "";
        }

        cursor_x += string_width(" ");
    }
    else if (ch == "\n") {
        // Draw the word before the newline
        if (word != "") {
            var word_w = string_width(word);
            if (cursor_x + word_w > text_x + wrap_width) {
                cursor_x = text_x;
                cursor_y += line_spacing;
            }
            draw_set_colour(current_col);
            draw_text(cursor_x, cursor_y, word);
            word = "";
        }

        // Hard line break
        cursor_x = text_x;
        cursor_y += line_spacing;
    }
    else {
        word += ch;
    }

    i += 1;
}

// Final word (if any)
if (word != "") {
    var word_w = string_width(word);
    if (cursor_x + word_w > text_x + wrap_width) {
        cursor_x = text_x;
        cursor_y += line_spacing;
    }
    draw_set_colour(current_col);
    draw_text(cursor_x, cursor_y, word);
}

draw_set_colour(c_white);

draw_set_alpha(1);