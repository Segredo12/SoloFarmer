extends Node

# Variables:
const SAVE_PATH = "res://files/config.cfg"; # Configurations Location:

var _config_file = ConfigFile.new(); # Creates ConfigFile;
var _settings = { # All Settings;
	"audio": {
		"isMusicBlocked": false,
		"isSFXBlocked": false
	},
	"screen": {
		"isFullscreen": true
	},
	"language": {
		"game_lang": "PT"	
	}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	#save_settings(); # Saves settings;
	load_settings(); # Loads settings;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Function that is going to save game configurations:
func save_settings():
	for section in _settings:
		for key in _settings[section]:
			_config_file.set_value(section, key, _settings[section][key]);
	_config_file.save(SAVE_PATH); # Saves the file onto SAVE_PATH;

# Function that is going to load game configurations:
func load_settings():
	# Open the file:
	var err = _config_file.load(SAVE_PATH);
	# Checks if it loaded:
	if err != OK: # If case file didn't loaded:
		print("Failed to load Configurations File, Error code %s" % err);
		return [err];
	# Retrive the values and store them in _settings:
	for section in _settings:
		for key in _settings[section]:
			_settings[section][key] = _config_file.get_value(section, key, null);

func get_setting(category, key):
	return _settings[category][key]; # Returns value from category and key:

func set_setting(category, key, value):
	_settings[category][key] = value; # Save the setting with the new value:
	save_settings(); # Saves onto file:
