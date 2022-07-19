extends itemClass

#SHOP ITEM
# Called when the node enters the scene tree for the first time.
#var playerInv = Inventory
var price
func _init():
	self.item_name = "Potion"
	self.item_description = "Restores HP"
	self.item_max = 1
	self.item_usable = true
	self.item_equipable = false
	price = 2

func use():
	#PASS TO PLAYER INVENTORY
	get_parent().remove_child(self)
	pass


func _on_Area2D_input_event(_viewport, event, _shape_idx):
	#print("signal recieved")
	if event is InputEventMouseButton:
		#print("event created")
		#if event.is_action_just_released("leftclick"):
		if self.price <= Playerstats.money  && event.is_pressed():
			#print("event clicked")
			self.use()
			Playerstats.money -= 2
