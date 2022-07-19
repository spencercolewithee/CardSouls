extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(PackedScene) var target

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _gui_input(_event):
	if Input.is_action_just_released("leftclick"):
		next_level()

func next_level():
	var error = get_tree().change_scene_to(target)
	if error != OK:
		print("problem loading next level")
