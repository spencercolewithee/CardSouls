extends Button
var minimum = 1

func _gui_input(_event):
	if Input.is_action_just_released("leftclick"):
		if ($'../'.LuckStat > minimum):
			$'../../luckStat'.LuckStat -=1
			$'../../luckStat'.text = str($'../../luckStat'.LuckStat)
			$'../../Total'.TotalStats += 1
			$'../../Total'.text = str($'../../Total'.TotalStats)
