extends Node2D


export(PackedScene) var window_scene
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Playerstats.world = "World6"
		get_tree().change_scene("res://RewardScenes/UpgradeReward.tscn")
