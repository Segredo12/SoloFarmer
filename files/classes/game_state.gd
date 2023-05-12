extends Node

# Variables:
const SAVE_PATH = "res://files/scene_content.cfg"; # Configurations Location:
var _config_file = ConfigFile.new(); # Creates ConfigFile;
var _contents = { # All Settings;
	"minerals": {
		"emerald": 5,
		"saphire": 5
	}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	load_scene(); # Loads Scene content;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Function that will load scene values:
# Example: Rocks Quantities, trees quantities, etc..
func load_scene():
	# Open the file:
	var err = _config_file.load(SAVE_PATH);
	if err != OK: # If case file didn't loaded:
		_config_file.save(SAVE_PATH); # Creates File:
		save_contents(); # Stores contents:
	# Read the file and add's to this content:
	for section in _contents:
		for key in _contents[section]:
			_contents[section][key] = _config_file.get_value(section, key, null);

# Function that will store contents from scene:
func save_contents():
	for section in _contents:
		for key in _contents[section]:
			_config_file.set_value(section, key, _contents[section][key]);
	_config_file.save(SAVE_PATH); # Saves the file onto SAVE_PATH;
	
# Function that will return an especific content:
func get_content(category, key):
	return _contents[category][key]; # Returns value from category and key:

# Function that will set a especific content:
func set_content(category, key, value):
	_contents[category][key] = value; # Save the content with the new value:
	save_contents(); # Saves onto file:
