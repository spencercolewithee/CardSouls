extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _gui_input(_event):
	if Input.is_action_just_released("leftclick"):
		$'../../'._handle_states(2)
