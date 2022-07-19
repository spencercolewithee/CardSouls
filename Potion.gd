extends itemClass


#PLAYER ITEM
func _ready():
	pass # Replace with function body.
var restore

func _init():
	self.item_name = "Potion"
	self.item_description = "Restores HP"
	self.item_max = 1
	self.item_usable = true
	self.item_equipable = false
	restore = 5
	
func use():
	Playerstats.health += restore
	get_parent().remove_child(self)

func _on_Area2D_input_event(viewport, event, shape_idx):
	#print("signal recieved")
	if event is InputEventMouseButton:
		#print("event created")
		#if event.is_action_just_released("leftclick"):
		if Playerstats.health + restore <= Playerstats.healthmax  && event.is_pressed():
			#print("event clicked")
			self.use()
			self.item_usable = false
