extends Area2D

export(PackedScene) var target
# Called when the node enters the scene tree for the first time.
func _ready():
	target = load("res://CombatEncounter.tscn")
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if get_overlapping_bodies().size() > 1:
			Playerstats.world = "World5"
			next_level()

func next_level():
	var error = get_tree().change_scene_to(target)
	if error != OK:
		print("problem loading next level")
