extends TextureButton


export(PackedScene) var target

# Called when the node enters the scene tree for the first time.
func _ready():
	target = load(str("res://Worlds/",Playerstats.world,".tscn"))


func _gui_input(_event):
	if Input.is_action_just_released("leftclick"):
		Playerstats.CardList.append($'../Cards'.get_children()[4].CardName)
		Playerstats.CardList1 = [] + Playerstats.CardList
		Playerstats.CardList2 = [] + Playerstats.CardList
		next_level()

func next_level():
	var error = get_tree().change_scene_to(target)
	if error != OK:
		print("problem loading next level")
