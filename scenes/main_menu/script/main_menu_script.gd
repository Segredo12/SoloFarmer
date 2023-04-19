extends Node

# Variables:
var game_lang = "PT";
var isLangChanged = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	# Hides Options_container:
	$options_container.hide();
	# Starts Background animation:
	$bird01.play(); # Starts Bird01 animation;
	$bird02.play(); # Starts Bird02 animation;
	# Now we start the Labels using game_lang variable:
	buttons_container_translation();
	options_container_translation();
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isLangChanged:
		# Language was changed on configuration:
		buttons_container_translation();
		options_container_translation();
		isLangChanged = false;

# Translations:
func buttons_container_translation():
	if game_lang == "PT":
		$buttons_container/new_game_btn.text = "Novo jogo";
		$buttons_container/option_btn.text = "Opções";
		$buttons_container/quit_game_btn.text = "Sair";
	elif game_lang == "EN":
		$buttons_container/new_game_btn.text = "New Game";
		$buttons_container/option_btn.text = "Options";
		$buttons_container/quit_game_btn.text = "Quit";
# Translations:
func options_container_translation():
	if game_lang == "PT":
		$options_container/language_label.text = "Idioma:";
		$options_container/save_options_btn.text = "Guardar";
		$options_container/cancel_options_btn.text = "Cancelar";
	elif game_lang == "EN":
		$options_container/language_label.text = "Language:";
		$options_container/save_options_btn.text = "Save";
		$options_container/cancel_options_btn.text = "Cancel";
	
func _on_quit_game_btn_pressed():
	# Game is going to quit.
	print("Quitting Game.");
	get_tree().quit();


func _on_option_btn_pressed():
	# Need to hide buttons_container:
	$buttons_container.hide();
	# Need to show options_container:
	$options_container.show();


func _on_new_game_btn_pressed():
	pass # Function that goes to start new game;


func _on_bird_timer_timeout():
	if $bird01.is_playing():
		$bird01.position.x += 10;
	if $bird02.is_playing():
		$bird02.position.x -= 10;
	if $bird01.position.x > 810:
		# Goes to start position;
		$bird01.position = $spawn_bird01.position;
		$bird01.stop();
		$bird_spawn_timer_01.start();
	if $bird02.position.x < -10:
		# Goes to start position;
		$bird02.position = $spawn_bird02.position;
		$bird02.stop();
		$bird_spawn_timer_02.start();
		

# Spawn Timer for Bird01;
func _on_bird_spawn_timer_01_timeout():
	if !$bird01.is_playing():
		$bird01.play();
		$bird_spawn_timer_01.stop();

# Spawn Timer for Bird02;
func _on_bird_spawn_timer_02_timeout():
	if !$bird02.is_playing():
		$bird02.play();
		$bird_spawn_timer_02.stop();

func _on_background_sound_finished():
	# Starts Background sound again:
	$background_sound.play(0.0);


func _on_pt_option_lang_btn_toggled(isToggled):
	if isToggled: # Case we're toggling it we remove toggle from EN;
		$options_container/en_option_lang_btn.button_pressed = false;
		game_lang = "PT";
		isLangChanged = true;
	if !isToggled: # Case we're removing toggle we need to check if EN is toggled;
		if !$options_container/en_option_lang_btn.button_pressed: # If EN is not toggled we continue with PT toggled;
			$options_container/pt_option_lang_btn.button_pressed = true;


func _on_en_option_lang_btn_toggled(isToggled):
	if isToggled: # Case we're toggling it we remove toggle from PT;
		$options_container/pt_option_lang_btn.button_pressed = false;
		game_lang = "EN";
		isLangChanged = true;
	if !isToggled: # Case we're removing toggle we need to check if PT is toggled;
		if !$options_container/pt_option_lang_btn.button_pressed: # If PT is not toggled we continue with EN toggled;
			$options_container/en_option_lang_btn.button_pressed = true;

# this function will check if game_lang is PT:
func _on_pt_option_lang_btn_ready():
	if game_lang == "PT":
		$options_container/pt_option_lang_btn.button_pressed = true;

# this function will check if game_lang is EN:
func _on_en_option_lang_btn_ready():
	if game_lang == "EN":
		$options_container/en_option_lang_btn.button_pressed = true;

# Option was saved:
func _on_save_options_btn_pressed():
	# Hides options_container:
	$options_container.hide();
	# Shows buttons_container:
	$buttons_container.show();
