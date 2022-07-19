extends Area2D

export(PackedScene) var target
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if Playerstats.canEscape:
			if get_overlapping_bodies().size() > 1:
				Playerstats.boss = true
				next_level()
		else:
			print("Door Locked")
			$'../DoorStatus'.show()

func next_level():
	var error = get_tree().change_scene_to(target)
	if error != OK:
		print("problem loading next level")
