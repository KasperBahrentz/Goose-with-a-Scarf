// Spawned from block center
direction = random(360);             // random direction
speed = random_range(3, 8);          // initial burst velocity

gravity = 0.15;
gravity_direction = 270;             // falling down

friction = 0.02;

image_index = irandom_range(0, image_number-1);

image_speed = 2 + random(2);     // slow spin
hspeed += random_range(-0.5, 0.5);   // slight wobble
vspeed += random_range(-0.5, 0.5);

life = 90 + irandom(30);             // optional: time to fade out

depth -= 1000;

var colors = [
    "#73ff73",
    "#ff8cc8",
    "#82ffe1",
    "#41d7d7",
    "#a041d7",
    "#e65ae6",
    "#b4236e",
    "#bed72d",
    "#1469c3",
    "#ffe65a",
    "#ffaa32",
    "#f06923",
    "#d72d2d"
];

image_blend = hex_to_color(colors[irandom(array_length(colors) - 1)]);