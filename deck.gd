extends itemClass

#signal hurt_enemy

func _ready():
	pass # Replace with function body.

func _init():
	self.item_name = "Deck of Cards"
	self.item_description = "Currently available cards"
	self.item_max = 1
	self.item_usable = true
	
func use():
	pass
	#Using it will open a menu to view all cards.
