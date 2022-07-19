extends Node

var interactor = get_parent()
var window_type #Type: Inventory
#scene to be made still containing window textures and button
export(PackedScene) var window_scene

func _input(event):
	#if tab is pressed
	if event.is_action_pressed("ui_focus_next"):
		#print("in if")
		toggle_window(interactor)
	#will have a load default inventory call
	#default_inven()

#if the window is not refrencing anything, call the subscene for the invetory, 
#else remove the inventory scene and resume player controls
func toggle_window(current_scene):
	#print(str(player))
	var root = get_tree().get_root()
	if not is_instance_valid(window_type):
		var overworld = root.get_child(root.get_child_count() - 1)
		window_type = window_scene.instance()
		current_scene = window_type
		overworld.add_child(current_scene)
		get_tree().set_current_scene(window_type)
		get_parent().hide()
	else:
		#print(str(player))
		window_type.queue_free()
		current_scene = get_parent()
		current_scene.show()
		#print(root.get_child_count())
