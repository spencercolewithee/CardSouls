extends Panel


# Declare member variables here. Examples:
#used to control item type, ie weapon, potion, etc.
var Class = null
#used to store item instance.
var item = null
# Called when the node enters the scene tree for the first time.
func _ready():
	Class = preload("res://Deck.tscn")
	item = Class.instance()
	add_child(item)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
