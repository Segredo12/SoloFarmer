extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var player_class; # Player Class File:

# Resources:
var uncut_saphires = 0;
var uncut_emeralds = 0;
var cut_saphires = 0;
var cut_emeralds = 0;
var wood_logs = 0;
var wood_planks = 0;
var gold_coins = 0;

func _ready():
	# Reads Player Class:
	player_class = get_node("/root/Player");
	update_resources();
	$emerald_information_msg.hide();
	$saphire_information_msg.hide();

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	update_resources();

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
	update_resources_labels();

# Function used to update resources labels:
func update_resources_labels():
	$resources_window/uncut_saphire_label.text = str(uncut_saphires);
	$resources_window/uncut_emerald_label.text = str(uncut_emeralds);
	# TODO: Not Implemented:
	#$resources_window.get_node("resources_container").get_node("cut_saphire_label").text = str(cut_saphires);
	#$resources_window.get_node("resources_container").get_node("cut_emerald_label").text = str(cut_emeralds);
	#$resources_window.get_node("resources_container").get_node("wood_logs_label").text = str(wood_logs);
	#$resources_window.get_node("resources_container").get_node("wood_planks_label").text = str(wood_planks);
	#$resources_window.get_node("resources_container").get_node("gold_coins_label").text = str(gold_coins);
