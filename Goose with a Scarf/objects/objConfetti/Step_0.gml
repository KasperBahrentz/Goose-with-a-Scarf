life--;
if (life <= 0) {
    instance_destroy();
}

// Optional: slow drift for fluttering
hspeed += lengthdir_x(0.1, random(360));
image_speed *= 0.99;