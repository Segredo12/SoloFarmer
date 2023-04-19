extends Node

# Variables:

# Called when the node enters the scene tree for the first time.
func _ready():
	$bird01.play(); # Starts Bird animation
	$bird02.play();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass;


func _on_quit_game_btn_pressed():
	# Game is going to quit.
	print("Quitting Game.");
	get_tree().quit();


func _on_option_btn_pressed():
	pass # Function that goes to option menu;


func _on_new_game_btn_pressed():
	pass # Function that goes to start new game;


func _on_bird_timer_timeout():
	if $bird01.is_playing():
		$bird01.position.x += 10;
	if $bird02.is_playing():
		$bird02.position.x -= 10;
	#if $bird.position.x > 810:
		# Goes to start position;
	#if $bird02.position.x < -10:
		# Goes to start position;
