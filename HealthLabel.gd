extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#text = str(Playerstats.health) + " / " + str(Playerstats.healthmax)
	pass

func _process(_delta):
	text = str(Playerstats.health) + " / " + str(Playerstats.healthmax)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
