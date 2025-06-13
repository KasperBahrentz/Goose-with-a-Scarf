// Destroy when done
if (_timer >= _life) {
    instance_destroy();
}


// Calculate wave offset
var wave = sin(_phase + _timer * _frequency);
var dx = (wave - _wave_last) * _amplitude;

// Save wave for next frame
_wave_last = wave;

// Zig-zag movement
_timer++;
y += _vspeed; // smooth upward float
// Apply delta to x
x += dx;

// Growth using subimages
if (image_index < 2) {
    image_index += image_speed;
} else {
    image_index = 2;
    image_speed = 0;
}

// Fade out
image_alpha = 1 - (_timer / _life);
