extends Button
var minimum = 1

func _gui_input(_event):
	if Input.is_action_just_released("leftclick"):
		if ($'../'.DexStat > minimum):
			$'../../dexStat'.DexStat -=1
			$'../../dexStat'.text = str($'../../dexStat'.DexStat)
			$'../../Total'.TotalStats += 1
			$'../../Total'.text = str($'../../Total'.TotalStats)

