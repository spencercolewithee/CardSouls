extends itemClass

#signal hurt_enemy

func _ready():
	pass

func _init():
	self.item_name = "Leather Amor"
	self.item_description = "Basic Amor, 1 damage reduction"
	self.item_max = 4
	self.item_usable = false
	self.item_equipable = true
	
func use():
	Playerstats.armor = 1
