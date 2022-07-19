extends Button

func _ready():
	pass # Replace with function body.

# Called when the node enters the scene tree for the first time.
func _gui_input(_event):
	if Input.is_action_just_released("leftclick"):
		get_tree().change_scene("res://World2.tscn")
		print("click")
