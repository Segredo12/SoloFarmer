extends Node

# Creates File Path to files Folder:
const FILE_PATH = "res://files";
# Creates File Name with the File Path:
const FILE_NAME = FILE_PATH + "/player_data.data";
# Creates a File Password to use as encryption: (NOT SECURE)
const FILE_PWD = "soloFarming123";
# Creating a default player information (JSON):
var player_data = {
	"name": "placeholder",
	"playable": false,
	"uncut_emeralds": 0,
	"uncut_saphires": 0,
	"cut_emeralds": 0,
	"cut_saphires": 0,
	"wood_logs": 0,
	"wood_planks": 0,
	"gold_coins": 0
};
# Called when the node enters the scene tree for the first time.
func _ready():
	# Initializing file..
	init_player_file();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func save():
	var file = FileAccess.open_encrypted_with_pass(FILE_NAME, FileAccess.WRITE, FILE_PWD);
	file.store_string(JSON.stringify(player_data));

func load():
	var file = FileAccess.open_encrypted_with_pass(FILE_NAME, FileAccess.READ, FILE_PWD);
	if file != null: # Validadtes if file exists using NULL;
		file.open(FILE_NAME, FileAccess.READ);
		var data = JSON.parse_string(file.get_as_text());
		file = null; # Closing File:
		if typeof(data) == TYPE_DICTIONARY:
			player_data = data;
		else:
			printerr("Corrupted file..");
	else:
		printerr("No saved data found..");

func init_player_file():
	var file = FileAccess.open_encrypted_with_pass(FILE_NAME, FileAccess.READ, FILE_PWD);
	if file == null: # Validadtes if file exists using NULL;
		print("Initializing the player file..");
		print("Data initializing: ", JSON.stringify(player_data));
		save();
	else:
		print("File already exists..");
		var data = JSON.parse_string(file.get_as_text());
		print("Player data loaded: ", data);
		player_data = data;

# Getter to get information about player:
func get_player():
	return player_data;
# Setter to set information about player:
func set_player(new_player_data):
	print("User requested a new save to player_data..");
	player_data = new_player_data;
	save();
# Function used to reset resources:
func reset_resources():
	player_data["uncut_emeralds"] = 0;
	player_data["uncut_saphires"] = 0;
	player_data["cut_saphires"] = 0;
	player_data["cut_emeralds"] = 0;
	player_data["wood_logs"] = 0;
	player_data["wood_planks"] = 0;
	player_data["gold_coins"] = 0;
