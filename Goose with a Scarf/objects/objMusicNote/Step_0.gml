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

// Apply wave delta
x += dx;
x -= random_range(0.5, 1); // slow drift to the left

// Step Event: Growth logic
if (image_index < base_index + max_growth) {
    image_index += image_speed;
    if (image_index > base_index + max_growth) {
        image_index = base_index + max_growth;
    }
} else {
    image_index = base_index + max_growth;
    image_speed = 0;
}

// Fade out
image_alpha = 1 - (_timer / _life);