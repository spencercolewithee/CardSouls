extends Button
var minimum = 1

func _gui_input(_event):
	if Input.is_action_just_released("leftclick"):
		if ($'../'.IntStat > minimum):
			$'../../intStat'.IntStat -=1
			$'../../intStat'.text = str($'../../intStat'.IntStat)
			$'../../Total'.TotalStats += 1
			$'../../Total'.text = str($'../../Total'.TotalStats)

