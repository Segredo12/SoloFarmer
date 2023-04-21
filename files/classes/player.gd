extends Node

# Creates File Path to files Folder:
const FILE_PATH = "res://files";
# Creates File Name with the File Path:
const FILE_NAME = FILE_PATH + "/player_data.json";
# Creates a File Password to use as encryption: (NOT SECURE)
const FILE_PWD = "soloFarming123";
# Creating a default player information (JSON):
var player_data = {
	"name": "placeholder",
	"playable": false
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
	print("User requested player_data: ", JSON.stringify(player_data));
	return player_data;
# Setter to set information about player:
func set_player(new_player_data):
	print("User requested a new save to player_data..");
	print("New player_data: " , JSON.stringify(new_player_data));
	player_data = new_player_data;
	save();
