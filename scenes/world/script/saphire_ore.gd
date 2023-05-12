extends StaticBody2D

# Ore Quantity:
@export var quantity = 5;
# Ore Respawn timer:
@export var respawn_timer = 5;

# Boolean is ore depleted:
var is_depleted = false;
# Read player class:
var player_class;
# Game_State Class File:
var game_state; 

# Called when the node enters the scene tree for the first time.
func _ready():
	# Reads Game State File:
	game_state = get_node("/root/GameState");
	# Reads file quantity:
	quantity = game_state.get_content("minerals", "saphire");
	# Starts the game with the correct sprite:
	show_correct_quantity_sprite_saphire();
	# Reads Player Class:
	player_class = get_node("/root/Player");


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	show_correct_quantity_sprite_saphire();
	if (!is_depleted):
		if ($"../player".position.x >= -770 && $"../player".position.x <= -755
			&& $"../player".position.y >= 730 && $"../player".position.y <= 740):
			# Shows Message to interact with the rock:
			$"../player".get_node("saphire_information_msg").text = "Interact with the Saphire using 'E'.";
			$"../player".get_node("saphire_information_msg").show();
			# Listens for interact key:
			if (Input.is_action_just_pressed("interact")):
				# Checks if ore has quantity left:
				if (quantity > 0):
					print("Player started Mining Saphire: ", quantity);
					# Reads player variables:
					var player = player_class.get_player();
					# Removes one ore from the mine;
					quantity -= 1;
					# Removes one from config file:
					game_state.set_content("minerals", "saphire", quantity);
					# Inserts uncut_saphires onto player:
					player["uncut_saphires"] = player["uncut_saphires"] + 1;
					print("Removed one from quantity: ", quantity);
					player_class.set_player(player);
		else:
			if ($"../player".get_node("saphire_information_msg").is_visible()):
				$"../player".get_node("saphire_information_msg").hide();
	else:
		# Removes Player information msg:
		if ($"../player".get_node("saphire_information_msg").is_visible()):
			$"../player".get_node("saphire_information_msg").hide();
		if ($respawn_timer.is_stopped() && is_depleted):
			# Await (seconds) to respawn rock:
			$respawn_timer.start(respawn_timer);

func show_correct_quantity_sprite_saphire():
	if (quantity == 5):
		$saphire_full.show();
		$saphire_sprite_04.hide();
		$saphire_sprite_03.hide();
		$saphire_sprite_02.hide();
		$saphire_sprite_01.hide();
	elif (quantity == 4):
		$saphire_full.hide();
		$saphire_sprite_04.show();
		$saphire_sprite_03.hide();
		$saphire_sprite_02.hide();
		$saphire_sprite_01.hide();
	elif (quantity == 3):
		$saphire_full.hide();
		$saphire_sprite_04.hide();
		$saphire_sprite_03.show();
		$saphire_sprite_02.hide();
		$saphire_sprite_01.hide();
	elif (quantity == 2):
		$saphire_full.hide();
		$saphire_sprite_04.hide();
		$saphire_sprite_03.hide();
		$saphire_sprite_02.show();
		$saphire_sprite_01.hide();
	elif (quantity == 1):
		$saphire_full.hide();
		$saphire_sprite_04.hide();
		$saphire_sprite_03.hide();
		$saphire_sprite_02.hide();
		$saphire_sprite_01.show();
	elif (quantity == 0):
		$saphire_full.hide();
		$saphire_sprite_04.hide();
		$saphire_sprite_03.hide();
		$saphire_sprite_02.hide();
		$saphire_sprite_01.hide();
		is_depleted = true;

func _on_respawn_timer_timeout():
	is_depleted = false;
	quantity = 5;
	print("Saphire ore restored..");
