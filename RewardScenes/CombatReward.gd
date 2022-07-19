extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const CardSize = Vector2(125, 175)*0.8
const CardBase = preload("res://CardScenes/AttackBase.tscn")
var CardSelected
var GoldList = [5, 10, 15]
var GoldWon = 0

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
	randomize()
	
	GoldWon = GoldList[randi() % GoldList.size()]
	GoldWon += Playerstats.luck
	$GoldWonText.text = str("         You won ",GoldWon)
	Playerstats.money += GoldWon
	
	if Playerstats.luck >= 8:
		var new_card = CardBase.instance()
		CardSelected = randi() % Playerstats.AllCards.size()
		new_card.CardName = Playerstats.AllCards[CardSelected]
		new_card.rect_position = Vector2(165,150)
		new_card.rect_scale *= CardSize/new_card.rect_size
		new_card.state = Display
		new_card.Make_Back_Invisible()
		
		$Cards.add_child(new_card)
	else:
		$Card0Button.disabled = true
		$Card0Button.visible = false
		$Label0.visible = false
	#-------------------------------------
	if Playerstats.luck >= 4:
		var new_card1 = CardBase.instance()
		CardSelected = randi() % Playerstats.AllCards.size()
		new_card1.CardName = Playerstats.AllCards[CardSelected]
		new_card1.rect_position = Vector2(315,150)
		new_card1.rect_scale *= CardSize/new_card1.rect_size
		new_card1.state = Display
		new_card1.Make_Back_Invisible()
		
		$Cards.add_child(new_card1)
	else:
		$Card1Button.disabled = true
		$Card1Button.visible = false
		$Label1.visible = false
	#-------------------------------------
	var new_card2 = CardBase.instance()
	CardSelected = randi() % Playerstats.AllCards.size()
	new_card2.CardName = Playerstats.AllCards[CardSelected]
	new_card2.rect_position = Vector2(465,150)
	new_card2.rect_scale *= CardSize/new_card2.rect_size
	new_card2.state = Display
	new_card2.Make_Back_Invisible()
	
	$Cards.add_child(new_card2)
	#-------------------------------------
	if Playerstats.luck >= 6:
		var new_card3 = CardBase.instance()
		CardSelected = randi() % Playerstats.AllCards.size()
		new_card3.CardName = Playerstats.AllCards[CardSelected]
		new_card3.rect_position = Vector2(615,150)
		new_card3.rect_scale *= CardSize/new_card3.rect_size
		new_card3.state = Display
		new_card3.Make_Back_Invisible()
		
		$Cards.add_child(new_card3)
	else:
		$Card3Button.disabled = true
		$Card3Button.visible = false
		$Label3.visible = false
	#-------------------------------------
	if Playerstats.luck >= 10:
		var new_card4 = CardBase.instance()
		CardSelected = randi() % Playerstats.AllCards.size()
		new_card4.CardName = Playerstats.AllCards[CardSelected]
		new_card4.rect_position = Vector2(765,150)
		new_card4.rect_scale *= CardSize/new_card4.rect_size
		new_card4.state = Display
		new_card4.Make_Back_Invisible()
		
		$Cards.add_child(new_card4)
	else:
		$Card4Button.disabled = true
		$Card4Button.visible = false
		$Label4.visible = false
	#-------------------------------------


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
