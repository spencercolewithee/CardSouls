extends Node2D


const CardSize = Vector2(125, 175)*0.8
const CardBase = preload("res://CardScenes/AttackBase.tscn")
var CardSelected = []
onready var DeckSize = Playerstats.CardList.size()

onready var CenterCardOval = get_viewport().size * Vector2(0.44, 1.40)
onready var HorRad = get_viewport().size.x*0.45
onready var VerRad = get_viewport().size.y*0.4


var angle = 0
var NumberCardsHand = -1
var Card_Numb = 0
var CardSpread = 0.002*CardSize.x
var OvalAngleVector = Vector2()

var DeckCountNum
var DiscardCountNum

enum {
	InHand
	InMouse
	FocusInHand
	MoveDrawnCardToHand
	ReOrganiseHand
	MoveDrawnCardToDiscard
}

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_viewport().size.x == 1024:
		CenterCardOval = get_viewport().size * Vector2(0.44, 1.40)
	elif get_viewport().size.x == 1920:
		CenterCardOval = get_viewport().size * Vector2(0.25, 1.0)
		HorRad = get_viewport().size.x*0.26
		VerRad = get_viewport().size.y*0.412
	randomize()
	
	DeckCountNum = Playerstats.CardList1.size()
	DiscardCountNum = 0
	$DeckCountText.text = str(DeckCountNum)
	pass

onready var DeckPosition = $Deck.position
onready var DiscardPosition = $Discard.position

func draw_card():
	if DeckSize == 0:
		Shuffle()
	angle = PI/2 + CardSpread*(float(NumberCardsHand)/2 - NumberCardsHand)
	var new_card = CardBase.instance()
	CardSelected = randi() % DeckSize
	new_card.CardName = Playerstats.CardList1[CardSelected]
	new_card.rect_position = DeckPosition
	new_card.DiscardPile = DiscardPosition
	new_card.rect_scale *= CardSize/new_card.rect_size
	new_card.state = MoveDrawnCardToHand
	Card_Numb = 0
	
	$CardEngine.add_child(new_card)
	DeckCountNum -=1
	$DeckCountText.text = str(DeckCountNum)
	
	Playerstats.CardList1.erase(Playerstats.CardList1[CardSelected])
	angle += 0.25
	DeckSize -= 1
	NumberCardsHand += 1
	OrgansieHand()
	return DeckSize

func ReParentCard(CardNo):
	NumberCardsHand -= 1
	Card_Numb = 0
	var Card = $CardEngine.get_child(CardNo)
	$CardEngine.remove_child(Card)
	$CardsInPlay.add_child(Card)
	OrgansieHand()

func Shuffle():
	for Card in $CardsInPlay.get_children():
		$CardsInPlay.remove_child(Card)
		DeckSize += 1
	Playerstats.CardList1 = [] + Playerstats.CardList2
	DiscardCountNum = 0
	DeckCountNum = Playerstats.CardList2.size() - 1
	$DeckCountText.text =str(DeckCountNum)

func OrgansieHand():
	for Card in $CardEngine.get_children():
		angle = PI/2 + CardSpread*(float(NumberCardsHand)/2 - Card_Numb)
		OvalAngleVector = Vector2(HorRad * cos(angle), - VerRad * sin(angle))
		
		Card.targetpos = CenterCardOval + OvalAngleVector - Vector2(0, CardSize.y)
		Card.Cardpos = Card.targetpos
		
		Card.startrot = Card.rect_rotation
		Card.targetrot = (90 - rad2deg(angle)) / 4
		
		Card.Card_Numb = Card_Numb
		
		Card_Numb += 1
		if Card.state == InHand:
			Card.setup = true
			Card.state = ReOrganiseHand
		elif Card.state == MoveDrawnCardToHand:
			#Card.t -= 0.1
			Card.startpos = Card.targetpos - ((Card.targetpos - Card.rect_position)/(1-Card.t))
