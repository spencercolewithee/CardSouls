extends Panel


# Declare member variables here. Examples:
#used to control item type, ie weapon, potion, etc.
var Class = preload("res://LeatherArmor.tscn")
#used to store item instance.
var item = null
var armor
# Called when the node enters the scene tree for the first time.
func _ready():
	item = Class.instance()
	add_child(item)
	item.use()
