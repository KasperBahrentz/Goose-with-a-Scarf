/// @description Insert description here
// You can write your code in this editor

depth -= 10;
instance_create_layer(x, y-2*objGame.pixel_size, "instances", objEgg, {spawn_coordinate : [x, y-2*objGame.pixel_size], temporary : true});