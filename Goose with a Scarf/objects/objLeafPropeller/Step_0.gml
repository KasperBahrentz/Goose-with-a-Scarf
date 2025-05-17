if (instance_exists(flower)){
	if (flower.is_landed_on){
		flower.draw_y = ystart;
		y = ystart;
		timer = 0;
	}
	else {
		fly();
		flower.draw_y = y;	
	}
}
else if(instance_exists(flower_bud)){
	fly();
	flower_bud.y = y;		
}

function fly() {
	y = min(ystart, y-sin(timer) / 4);
	timer += 0.02;
}