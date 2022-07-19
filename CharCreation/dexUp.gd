extends Button
var maximum = 12

func _gui_input(_event):
	if Input.is_action_just_released("leftclick"):
		if ($'../'.DexStat < maximum && $'../../Total'.TotalStats > 0):
			$'../../Total'.TotalStats -= 1
			$'../../Total'.text = str($'../../Total'.TotalStats)
			$'../../dexStat'.DexStat +=1
			$'../../dexStat'.text = str($'../../dexStat'.DexStat)
