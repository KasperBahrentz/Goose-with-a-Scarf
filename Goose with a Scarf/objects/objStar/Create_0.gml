far_away = choose(true, false, false);

if (far_away){
	image_index++;	
}
else {	
	image_xscale = choose(1, -1);
	image_yscale = choose(-1, 1);
}

timer = irandom_range(0, 1000);
