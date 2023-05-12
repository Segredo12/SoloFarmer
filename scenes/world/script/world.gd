extends Node2D

var player_class; # Player Class File:

# Called when the node enters the scene tree for the first time.
func _ready():
	# Reads Player Class:
	player_class = get_node("/root/Player");

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Checks if player is on the door of the house:
	if ($player.position.x >= 330 && $player.position.x <= 360
		&& $player.position.y >= 485 && $player.position.y <= 500):
		# TODO: Enter the building..
