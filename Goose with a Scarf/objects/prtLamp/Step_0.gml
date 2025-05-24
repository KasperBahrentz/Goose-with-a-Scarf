flicker_phase += flicker_speed; // smooth, continuous angle increment

flicker_timer += 1;
if (flicker_timer > flicker_interval) {
    flicker_speed = random_range(0.01, 0.06);          // new smooth speed
    flicker_interval = irandom_range(90, 150);         // time until next change
    flicker_timer = 0;
}
