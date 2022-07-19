extends Button
var minimum = 1

func _gui_input(_event):
	if Input.is_action_just_released("leftclick"):
		if ($'../'.StrengthStat > minimum):
			$'../../strStat'.StrengthStat -=1
			$'../../strStat'.text = str($'../../strStat'.StrengthStat)
			$'../../Total'.TotalStats += 1
			$'../../Total'.text = str($'../../Total'.TotalStats)
