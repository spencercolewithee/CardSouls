extends TextureButton



#var interactor = get_parent()
#var window_type #Type: Inventory
#scene to be made still containing window textures and button
export(PackedScene) var window_scene

func _on_DeckCount_pressed():
	var root = get_tree().get_root()
	var window_type = window_scene.instance()
	var current_scene = window_type
	root.add_child(current_scene)
#	root.get_children()[1].add_child(current_scene)
	get_tree().set_current_scene(window_type)
	get_parent().hide()
