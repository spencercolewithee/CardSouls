extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const CardSize = Vector2(125, 175)*0.6
const CardBase = preload("res://CardScenes/AttackBase.tscn")
var StartPos = Vector2(-60,10)
var Count = 1
var RowCount = 1

enum {
	InHand
	InMouse
	FocusInHand
	MoveDrawnCardToHand
	ReOrganiseHand
	MoveDrawnCardToDiscard
	Display
}

# Called when the node enters the scene tree for the first time.
func _ready():
	for Card in Playerstats.CardList1:
		var new_card = CardBase.instance()
		new_card.CardName = Card
		new_card.rect_position = StartPos + Vector2(77, 0)
		new_card.rect_scale *= CardSize/new_card.rect_size
		new_card.state = Display
		new_card.Make_Back_Invisible()
		$Cards.add_child(new_card)
		if ((Count % 13) == 0) && (Count != 0):
			StartPos = Vector2(-60,107*RowCount)
			RowCount += 1
		else:
			StartPos = StartPos + Vector2(77, 0)
		Count += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
