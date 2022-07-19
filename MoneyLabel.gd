extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	#text = str(Playerstats.health) + " / " + str(Playerstats.healthmax)
	pass

func _process(_delta):
	text = str(Playerstats.money) + " Gold"
