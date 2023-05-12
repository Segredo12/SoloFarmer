extends StaticBody2D

# Ore Quantity:
@export var quantity = 5;
# Ore Respawn timer:
@export var respawn_timer = 5;

var game_state; # Game_State Class File:

# Boolean is ore depleted:
var is_depleted = false;
# Read player class:
var player_class;

# Called when the node enters the scene tree for the first time.
func _ready():
	# Reads Game State File:
	game_state = get_node("/root/GameState");
	# Reads file quantity:
	quantity = game_state.get_content("minerals", "emerald");
	# Starts the game with the correct sprite:
	show_correct_quantity_sprite_emerald();
	# Reads Player Class:
	player_class = get_node("/root/Player");


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	show_correct_quantity_sprite_emerald();
	if (!is_depleted):
		if ($"../player".position.x >= -920 && $"../player".position.x <= -910
			&& $"../player".position.y >= 730 && $"../player".position.y <= 740):
			# Shows Message to interact with the rock:
			$"../player".get_node("emerald_information_msg").text = "Interact with the Emerald using 'E'.";
			$"../player".get_node("emerald_information_msg").show();
			# Listens for interact key:
			if (Input.is_action_just_pressed("interact")):
				# Checks if ore has quantity left:
				if (quantity > 0):
					print("Player started Mining Emerald: ", quantity);
					# Reads player variables:
					var player = player_class.get_player();
					# Removes one ore from the mine;
					quantity -= 1;
					# Removes one from config file:
					game_state.set_content("minerals", "emerald", quantity);
					# Inserts uncut_emeralds onto player:
					player["uncut_emeralds"] = player["uncut_emeralds"] + 1;
					print("Removed one from quantity: ", quantity);
					player_class.set_player(player);
		else:
			if ($"../player".get_node("emerald_information_msg").is_visible()):
				$"../player".get_node("emerald_information_msg").hide();
	else:
		# Removes Player information msg:
		if ($"../player".get_node("emerald_information_msg").is_visible()):
			$"../player".get_node("emerald_information_msg").hide();
		if ($respawn_timer.is_stopped() && is_depleted):
			# Await (seconds) to respawn rock:
			$respawn_timer.start(respawn_timer);

func show_correct_quantity_sprite_emerald():
	if (quantity == 5):
		$emerald_full.show();
		$emerald_sprite_04.hide();
		$emerald_sprite_03.hide();
		$emerald_sprite_02.hide();
		$emerald_sprite_01.hide();
	elif (quantity == 4):
		$emerald_full.hide();
		$emerald_sprite_04.show();
		$emerald_sprite_03.hide();
		$emerald_sprite_02.hide();
		$emerald_sprite_01.hide();
	elif (quantity == 3):
		$emerald_full.hide();
		$emerald_sprite_04.hide();
		$emerald_sprite_03.show();
		$emerald_sprite_02.hide();
		$emerald_sprite_01.hide();
	elif (quantity == 2):
		$emerald_full.hide();
		$emerald_sprite_04.hide();
		$emerald_sprite_03.hide();
		$emerald_sprite_02.show();
		$emerald_sprite_01.hide();
	elif (quantity == 1):
		$emerald_full.hide();
		$emerald_sprite_04.hide();
		$emerald_sprite_03.hide();
		$emerald_sprite_02.hide();
		$emerald_sprite_01.show();
	elif (quantity == 0):
		$emerald_full.hide();
		$emerald_sprite_04.hide();
		$emerald_sprite_03.hide();
		$emerald_sprite_02.hide();
		$emerald_sprite_01.hide();
		is_depleted = true;


func _on_respawn_timer_timeout():
	is_depleted = false;
	quantity = 5;
	print("Emerald ore restored..");
