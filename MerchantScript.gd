extends Area2D

#scene to be made still containing window textures and button
export(PackedScene) var window_scene
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://MerchanUI.tscn")
#
#func shop():
#	var error = get_tree().change_scene_to(window_scene)
#	if error != OK:
#		print("problem loading next level")

#func _on_Area2D_input_event(_viewport, event, _shape_idx):
#	if event is InputEventKey:
#		print("button pressed")
#		if event.is_action_pressed("ui_accept"):
#			print("pressed in hitbox")
