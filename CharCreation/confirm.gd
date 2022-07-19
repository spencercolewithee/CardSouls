extends Button
export(PackedScene) var target
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _gui_input(_event):
	if Input.is_action_just_released("leftclick"):
		print(Playerstats.strength, Playerstats.dex, Playerstats.intel, Playerstats.luck)
		Playerstats.strength = $'../strStat'.StrengthStat
		Playerstats.dex = $'../dexStat'.DexStat
		Playerstats.intel = $'../intStat'.IntStat
		Playerstats.luck = $'../luckStat'.LuckStat
		print(Playerstats.strength, Playerstats.dex, Playerstats.intel, Playerstats.luck)
		#grab stats from labels and send to overworld player stat
		var error = get_tree().change_scene_to(target)
		if error != OK:
			print("problem loading next level")

