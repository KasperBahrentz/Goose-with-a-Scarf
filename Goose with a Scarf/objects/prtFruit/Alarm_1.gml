if (objGooseBody.state == player_state.MOVE) or (instance_exists(objGoal) and objGoal.goal_touched == true){
	state = fruit_state.COLLECT;
	audio_play_sound(sndPling, 15, false);
	image_speed = img_speed;
	objGame.number_of_fruit_collected[fruit_index]++;
	instance_create_layer(-100, -100, "instances", objFruitCollectedGUI, {fruit : self.object_index});
}