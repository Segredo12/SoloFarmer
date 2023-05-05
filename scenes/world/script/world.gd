extends Node2D

var player_class; # Player Class File:

# Resources:
var uncut_saphires = 0;
var uncut_emeralds = 0;
var cut_saphires = 0;
var cut_emeralds = 0;
var wood_logs = 0;
var wood_planks = 0;
var gold_coins = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	# Reads Player Class:
	player_class = get_node("/root/Player");
	# Hides resources container:
	$in_game_hud.get_node("resources_container").hide();
	# Updates Resources:
	update_resources();
	# Updates resources labels:
	update_resources_labels();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Checks if player is on the door of the house:
	if ($player.position.x >= 330 && $player.position.x <= 360
		&& $player.position.y >= 485 && $player.position.y <= 500):
		# Updates Resources:
		update_resources();
		# Updates resources labels:
		update_resources_labels();
		# Shows frame with the resources:
		$in_game_hud.get_node("resources_container").show();
	else:
		$in_game_hud.get_node("resources_container").hide();

# Function used to update game resources with file resources:
func update_resources():
	var player = player_class.get_player();
	uncut_saphires = player["uncut_saphires"];
	uncut_emeralds = player["uncut_emeralds"];
	cut_saphires = player["cut_saphires"];
	cut_emeralds = player["cut_emeralds"];
	wood_logs = player["wood_logs"];
	wood_planks = player["wood_planks"];
	gold_coins = player["gold_coins"];

# Function used to update resources labels:
func update_resources_labels():
	$in_game_hud.get_node("resources_container").get_node("uncut_saphire_label").text = str(uncut_saphires);
	$in_game_hud.get_node("resources_container").get_node("uncut_emerald_label").text = str(uncut_emeralds);
	$in_game_hud.get_node("resources_container").get_node("cut_saphire_label").text = str(cut_saphires);
	$in_game_hud.get_node("resources_container").get_node("cut_emerald_label").text = str(cut_emeralds);
	$in_game_hud.get_node("resources_container").get_node("wood_logs_label").text = str(wood_logs);
	$in_game_hud.get_node("resources_container").get_node("wood_planks_label").text = str(wood_planks);
	$in_game_hud.get_node("resources_container").get_node("gold_coins_label").text = str(gold_coins);
