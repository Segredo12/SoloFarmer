extends Node

# Variables:
var game_configurations; # Game_Configurations Class File:
var player_class; # Player Class File:
var game_state; # Game_State Class File:
var isLangChanged = false;
var isToCreateGameplay = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	# Reads Configurations File:
	game_configurations = get_node("/root/GameConfigurations");
	# Reads Player Class:
	player_class = get_node("/root/Player");
	# Reads Game State File:
	game_state = get_node("/root/GameState");
	# Listeners on _Ready():
	_on_pt_option_lang_btn_ready();
	_on_en_option_lang_btn_ready();
	_on_music_option_btn_ready();
	_on_effects_option_btn_ready();
	_on_fullscreen_option_btn_ready();
	# Hides Options_container:
	$options_container.hide();
	# Hides Start_game_container:
	$start_game_container.hide();
	# Starts Background animation:
	$bird01.play(); # Starts Bird01 animation;
	$bird02.play(); # Starts Bird02 animation;
	# Now we start the Labels using game_lang variable:
	buttons_container_translation();
	options_container_translation();
	start_game_container_translation();
	# We block music if isMusicBlocked as TRUE;
	if game_configurations.get_setting("audio", "isMusicBlocked"):
		$background_sound.stop();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if isLangChanged:
		# Language was changed on configuration:
		buttons_container_translation();
		options_container_translation();
		start_game_container_translation();
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
# Translation:
func start_game_container_translation():
	if game_configurations.get_setting("language", "game_lang") == "EN":
		$start_game_container/back_start_game_btn.text = "Back";
		$start_game_container/new_game_start_game_btn.text = "New Game";
		$start_game_container/empty_start_game_label.text = "Empty";
		$start_game_container/confirm_name_start_game_btn.text = "Confirm";
		$start_game_container/name_start_game_label.text = "Player Name:";
		$start_game_container/play_game_start_game_btn.text = "Play";
		$start_game_container/delete_player_start_game_btn.text = "Delete";
	elif game_configurations.get_setting("language", "game_lang") == "PT":
		$start_game_container/back_start_game_btn.text = "Voltar";
		$start_game_container/new_game_start_game_btn.text = "Novo Jogo";
		$start_game_container/empty_start_game_label.text = "Vazio";
		$start_game_container/confirm_name_start_game_btn.text = "Confirmar";
		$start_game_container/name_start_game_label.text = "Nome Jogador:";
		$start_game_container/play_game_start_game_btn.text = "Jogar";
		$start_game_container/delete_player_start_game_btn.text = "Remover";
# Sound to Play:
func play_sfx_menu_btn_sound():
	if !game_configurations.get_setting("audio", "isSFXBlocked"):
		# Plays Btn Click Sound:
		$btn_click_sound.play(0.0);

# Function used to show nodes from start_game_container:
func show_start_game_container_content():
	if (isToCreateGameplay):
		# We need to hide start_game container content:
		show_start_game_container_main_content();
		# We're Going to show Creating account content:
		$start_game_container/confirm_name_start_game_btn.show();
		$start_game_container/name_start_game_input.show();
		$start_game_container/name_start_game_label.show();
	else:
		# We're Going to hide Creating account content:
		$start_game_container/confirm_name_start_game_btn.hide();
		$start_game_container/name_start_game_input.hide();
		$start_game_container/name_start_game_label.hide();
		# We need to show start_game container content:
		show_start_game_container_main_content();

func show_start_game_container_main_content():
	var player = player_class.get_player();
	if player["playable"] and !isToCreateGameplay:
		# We need to hide start_game container content:
		$start_game_container/new_game_start_game_btn.hide();
		$start_game_container/empty_start_game_label.hide();
		# We need to show player_name_label, play_game_btn and remove_player_btn:
		$start_game_container/player_name_start_game_label.text = player["name"];
		$start_game_container/player_name_start_game_label.show();
		$start_game_container/play_game_start_game_btn.show();
		$start_game_container/delete_player_start_game_btn.show();
	else:
		if !isToCreateGameplay:
			# We need to show start_game container content:
			$start_game_container/new_game_start_game_btn.show();
			$start_game_container/empty_start_game_label.show();
		else:
			# We need to hide start_game container content:
			$start_game_container/new_game_start_game_btn.hide();
			$start_game_container/empty_start_game_label.hide();
		# We need to hide player_name_label, play_game_btn and remove_player_btn:
		$start_game_container/player_name_start_game_label.hide();
		$start_game_container/play_game_start_game_btn.hide();
		$start_game_container/delete_player_start_game_btn.hide();

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
	# Hides buttons_container:
	$buttons_container.hide();
	# Shows start_game_container:
	$start_game_container.show();
	# Shows start_game_container content:
	show_start_game_container_content();


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

# Listener to Back Button on start_game_container:
func _on_back_start_game_btn_pressed():
	play_sfx_menu_btn_sound();
	# Resets isToCreateGameplay variable to false:
	isToCreateGameplay = false;
	# Hides start_game_container:
	$start_game_container.hide();
	# Shows buttons_container:
	$buttons_container.show();

# Listener to add a new game save:
func _on_new_game_start_game_btn_pressed():
	play_sfx_menu_btn_sound();
	# Puts variable isToCreateGameplay as true:
	isToCreateGameplay = true;
	# Shows content for the new start_game:
	show_start_game_container_content();


func _on_confirm_name_start_game_btn_pressed():
	play_sfx_menu_btn_sound();
	# Puts variable isToCreateGameplay as false:
	isToCreateGameplay = false;
	# Prints out Player name choosen by the player:
	print("Player name: ", $start_game_container/name_start_game_input.text);
	var player_info = player_class.get_player(); # Getting Player information:
	player_info["name"] = $start_game_container/name_start_game_input.text; # Putting new Name onto Player:
	player_info["playable"] = true;
	player_class.set_player(player_info);
	# Now we need to create this new player:
	# TODO: Player File:
	# Clears player name from name_start_game_input:
	$start_game_container/name_start_game_input.clear();
	# Shows content for the new start_game:
	show_start_game_container_content();


func _on_delete_player_start_game_btn_pressed():
	play_sfx_menu_btn_sound();
	# Clears out Player:
	var player_info = player_class.get_player(); # Getting Player information:
	player_info["playable"] = false; # Puts player off playing mode;
	player_info["name"] = ""; # Removes old name;
	player_class.reset_resources();
	player_class.set_player(player_info);
	# Now we show content to the start_game container:
	show_start_game_container_content();


func _on_play_game_start_game_btn_pressed():
	play_sfx_menu_btn_sound();
	# Now we change to the gameplay scene:
	# TODO: Create a scene inside a house.
	# DEBUG: We're going to change to World while house not builded:
	get_tree().change_scene_to_file("res://scenes/world/world.tscn");
