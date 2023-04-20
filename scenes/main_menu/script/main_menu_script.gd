extends Node

# Variables:
var game_configurations;
var isLangChanged = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	# Reads Configurations File:
	game_configurations = get_node("/root/GameConfigurations");
	# Listeners on _Ready():
	_on_pt_option_lang_btn_ready();
	_on_en_option_lang_btn_ready();
	_on_music_option_btn_ready();
	_on_effects_option_btn_ready();
	_on_fullscreen_option_btn_ready();
	# Hides Options_container:
	$options_container.hide();
	# Starts Background animation:
	$bird01.play(); # Starts Bird01 animation;
	$bird02.play(); # Starts Bird02 animation;
	# Now we start the Labels using game_lang variable:
	buttons_container_translation();
	options_container_translation();
	# We block music if isMusicBlocked as TRUE;
	if game_configurations.get_setting("audio", "isMusicBlocked"):
		$background_sound.stop();
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if isLangChanged:
		# Language was changed on configuration:
		buttons_container_translation();
		options_container_translation();
		isLangChanged = false;

# Translations:
func buttons_container_translation():
	if game_configurations.get_setting("language", "game_lang") == "PT":
		$buttons_container/start_game_btn.text = "Começar Jogo";
		$buttons_container/option_btn.text = "Opções";
		$buttons_container/quit_game_btn.text = "Sair";
	elif game_configurations.get_setting("language", "game_lang") == "EN":
		$buttons_container/start_game_btn.text = "Start Game";
		$buttons_container/option_btn.text = "Options";
		$buttons_container/quit_game_btn.text = "Quit";
# Translations:
func options_container_translation():
	if game_configurations.get_setting("language", "game_lang") == "PT":
		$options_container/language_label.text = "Idioma:";
		$options_container/back_options_btn.text = "Voltar";
		$options_container/sound_label.text = "Som:";
		$options_container/music_option_btn.text = "Música";
		$options_container/effects_option_btn.text = "Efeitos";
		fullscreen_configuration_translation();
	elif game_configurations.get_setting("language", "game_lang") == "EN":
		$options_container/language_label.text = "Language:";
		$options_container/back_options_btn.text = "Back";
		$options_container/sound_label.text = "Sound:";
		$options_container/music_option_btn.text = "Music";
		$options_container/effects_option_btn.text = "Effects";
		fullscreen_configuration_translation();
# Translations:
func fullscreen_configuration_translation():
	if game_configurations.get_setting("language", "game_lang") == "EN":
		if game_configurations.get_setting("screen", "isFullscreen"):
			$options_container/fullscreen_option_btn.text = "Fullscreen";
		elif !game_configurations.get_setting("screen", "isFullscreen"):
			$options_container/fullscreen_option_btn.text = "Windowed";
	elif game_configurations.get_setting("language", "game_lang") == "PT":
		if game_configurations.get_setting("screen", "isFullscreen"):
			$options_container/fullscreen_option_btn.text = "Ecrã Inteiro";
		elif !game_configurations.get_setting("screen", "isFullscreen"):
			$options_container/fullscreen_option_btn.text = "Janela";

# Sound to Play:
func play_sfx_menu_btn_sound():
	if !game_configurations.get_setting("audio", "isSFXBlocked"):
		# Plays Btn Click Sound:
		$btn_click_sound.play(0.0);

func _on_quit_game_btn_pressed():
	# Saves Configuration file before exiting:
	game_configurations.save_settings(); # Saves onto file:
	# Game is going to quit.
	print("Quitting Game.");
	get_tree().quit();


func _on_option_btn_pressed():
	play_sfx_menu_btn_sound();
	# Need to hide buttons_container:
	$buttons_container.hide();
	# Need to show options_container:
	$options_container.show();


func _on_start_game_btn_pressed():
	play_sfx_menu_btn_sound();
	# Opens a window with saved game:
	# Case there's no save game we need to create one:


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
		game_configurations.set_setting("language", "game_lang", "PT");
		isLangChanged = true;
	if !isToggled: # Case we're removing toggle we need to check if EN is toggled;
		if !$options_container/en_option_lang_btn.button_pressed: # If EN is not toggled we continue with PT toggled;
			$options_container/pt_option_lang_btn.button_pressed = true;


func _on_en_option_lang_btn_toggled(isToggled):
	if isToggled: # Case we're toggling it we remove toggle from PT;
		$options_container/pt_option_lang_btn.button_pressed = false;
		game_configurations.set_setting("language", "game_lang", "EN");
		isLangChanged = true;
	if !isToggled: # Case we're removing toggle we need to check if PT is toggled;
		if !$options_container/pt_option_lang_btn.button_pressed: # If PT is not toggled we continue with EN toggled;
			$options_container/en_option_lang_btn.button_pressed = true;

# this function will check if game_lang is PT:
func _on_pt_option_lang_btn_ready():
	if game_configurations.get_setting("language", "game_lang") == "PT":
		$options_container/pt_option_lang_btn.button_pressed = true;

# this function will check if game_lang is EN:
func _on_en_option_lang_btn_ready():
	if game_configurations.get_setting("language", "game_lang") == "EN":
		$options_container/en_option_lang_btn.button_pressed = true;

# Option was saved:
func _on_back_options_btn_pressed():
	play_sfx_menu_btn_sound();
	# Hides options_container:
	$options_container.hide();
	# Shows buttons_container:
	$buttons_container.show();

# After toggeling the button:
func _on_music_option_btn_toggled(isToggled):
	if isToggled:
		# We're going to play music:
		$background_sound.play(0.0);
		$options_container/music_option_btn.button_pressed = true;
		game_configurations.set_setting("audio", "isMusicBlocked", false);
	elif !isToggled:
		# Otherwise we stop the music:
		$background_sound.stop();
		$options_container/music_option_btn.button_pressed = false;
		game_configurations.set_setting("audio", "isMusicBlocked", true);

# On Ready:
func _on_music_option_btn_ready():
	if game_configurations.get_setting("audio", "isMusicBlocked"):
		$background_sound.stop();
		$options_container/music_option_btn.button_pressed = false;
	elif !game_configurations.get_setting("audio", "isMusicBlocked"):
		$background_sound.play(0.0);
		$options_container/music_option_btn.button_pressed = true;


func _on_effects_option_btn_toggled(isToggled):
	if isToggled:
		# We're going to play SFX sounds:
		$options_container/effects_option_btn.button_pressed = true;
		game_configurations.set_setting("audio", "isSFXBlocked", false);
	elif !isToggled:
		# We're going to block SFX sounds:
		$options_container/effects_option_btn.button_pressed = false;
		game_configurations.set_setting("audio", "isSFXBlocked", true);


func _on_effects_option_btn_ready():
	if game_configurations.get_setting("audio", "isSFXBlocked"):
		$options_container/effects_option_btn.button_pressed = false;
	elif !game_configurations.get_setting("audio", "isSFXBlocked"):
		$options_container/effects_option_btn.button_pressed = true;


func _on_fullscreen_option_btn_toggled(isToggled):
	if isToggled:
		game_configurations.set_setting("screen", "isFullscreen", true);
		$options_container/fullscreen_option_btn.button_pressed = true;
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN);
	elif !isToggled:
		game_configurations.set_setting("screen", "isFullscreen", false);
		$options_container/fullscreen_option_btn.button_pressed = false;
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	# Rewrites Button Label:
	fullscreen_configuration_translation();


func _on_fullscreen_option_btn_ready():
	if game_configurations.get_setting("screen", "isFullscreen"):
		$options_container/fullscreen_option_btn.button_pressed = true;
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	elif !game_configurations.get_setting("screen", "isFullscreen"):
		$options_container/fullscreen_option_btn.button_pressed = false;
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

# Listener to when btn_click_sound finishes:
func _on_btn_click_sound_finished():
	$btn_click_sound.stop();
