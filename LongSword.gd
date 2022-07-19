extends itemClass

#signal hurt_enemy

func _ready():
	pass

func _init():
	self.item_name = "Longsword"
	self.item_description = "Basic longsword, scales with strength"
	self.item_max = 4
	self.item_usable = false
	self.item_equipable = true
	
func use():
	pass
	#once enemies are set up this will subtract enemy health.
	#emit_signal("hurt_enemy")
	#in enemy have 
	#$Player.connect("hurt_enemy",self,"was_hurt")
