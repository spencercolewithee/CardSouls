extends Button
var maximum = 12

func _gui_input(_event):
	if Input.is_action_just_released("leftclick"):
		if ($'../'.StrengthStat < maximum && $'../../Total'.TotalStats > 0):
			$'../../Total'.TotalStats -= 1
			$'../../Total'.text = str($'../../Total'.TotalStats)
			$'../../strStat'.StrengthStat +=1
			$'../../strStat'.text = str($'../../strStat'.StrengthStat)
