extends MarginContainer


# Declare member variables here. Examples:
onready var CardDatabase = preload("res://Assets/Cards/CardsDatabase.gd")

var CardName = 'Strike'


onready var CardInfo = CardDatabase.DATA[CardDatabase.get(CardName)]

onready var FaceImg = str("res://Assets/Cards/BordersAndBacks/",CardInfo[0],"/Square_Face.png")
onready var PortraitImg = str("res://Assets/Cards/Units/",CardInfo[0],"/",CardInfo[1],".png")
onready var FrameImg = str("res://Assets/Cards/BordersAndBacks/",CardInfo[2],"/Square_Frame.png")
onready var BannerImg = str("res://Assets/Cards/BordersAndBacks/",CardInfo[2],"/Banner.png")
onready var CostImg = str("res://Assets/Cards/BordersAndBacks/",CardInfo[0],"/Energy.png")

enum {
	InHand
	InMouse
	FocusInHand
	MoveDrawnCardToHand
	ReOrganiseHand
	MoveDrawnCardToDiscard
	MoveHandToDiscard
	Display
}
var state = InHand

var startpos = 0
var targetpos = 0
var startrot = 0
var targetrot = 0
var t = 0
var DRAWTIME = 1
var DISCARDTIME = 0.3
var ORGANISETIME = 0.5
onready var OrigScale = rect_scale

var setup = true
var startscale = Vector2()
var Cardpos = Vector2()
var ZoomInSize = 2
var ZOOMINTIME = 0.2
var ReorganiseNeighbors = true
var NumberCardsHand = 0
var Card_Numb = 0
var NeighborCard
var Move_Neighbor_Card_Check = false
var oldstate = INF
var CARD_SELECT = true
var INMOUSETIME = 0.1
var DiscardPile = Vector2()
var MovingToDiscard = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var _CardSize = rect_size
	
	$Face.texture = load(FaceImg)
	#$Face.scale *= CardSize/$Face.texture.get_size()
	#$Back.scale *= CardSize/$Back.texture.get_size()
	
	$Face/Description.text = str(CardInfo[3])
	
	$Portrait.texture = load(PortraitImg)
	
	$Frame.texture = load(FrameImg)
	
	$Banner.texture = load(BannerImg)
	$Banner/NameText.text = str(CardInfo[1])
	
	$Cost.texture = load(CostImg)
	$Cost/CostText.text = str(CardInfo[4])

func _input(event):
	match state:
		FocusInHand, InMouse:
			if event.is_action_pressed("leftclick"):
				if CARD_SELECT:
					oldstate = state
					state = InMouse
					setup = true
					CARD_SELECT = false
			if event.is_action_released("leftclick"):
				if CARD_SELECT == false:
					if CardInfo[0] == "Attack":
						#var Enemies = $'../../Enemies'
						for Enemy in $'../../Enemies'.get_children():
							var EnemyPos = Enemy.rect_position + Vector2(100, 0)
							var EnemySize = Enemy.rect_size * Vector2(0.5,0.5)
							var mousepos = get_global_mouse_position()
							if mousepos.x < EnemyPos.x + EnemySize.x && mousepos.x > EnemyPos.x \
								&& mousepos.y < EnemyPos.y + EnemySize.y && mousepos.y > EnemyPos.y:
									if Playerstats.CurrentStamina >= CardInfo[4]:
										Playerstats.CurrentStamina -= CardInfo[4]
										$'../../Stamina/StaminaText'.text = str(str(Playerstats.CurrentStamina),"/",str(Playerstats.MaxStamina))
										
										$'../../Players/Player'.PlayCard(CardInfo[1], Enemy.get_index())
										setup = true
										MovingToDiscard = true
										state = MoveDrawnCardToDiscard
										CARD_SELECT = true
										break
									else:
										setup = true
										targetpos = Cardpos
										state = ReOrganiseHand
										CARD_SELECT = true
							else:
								setup = true
								targetpos = Cardpos
								state = ReOrganiseHand
								CARD_SELECT = true
					else:
						var PlayerPos = $'../../Players/Player'.rect_position
						var PlayerSize = $'../../Players/Player'.rect_size
						var mousepos = get_global_mouse_position()
						if mousepos.x < PlayerPos.x + PlayerSize.x && mousepos.x > PlayerPos.x \
							&& mousepos.y < PlayerPos.y + PlayerSize.y && mousepos.y > PlayerPos.y:
								if Playerstats.CurrentStamina >= CardInfo[4]:
									Playerstats.CurrentStamina -= CardInfo[4]
									$'../../Stamina/StaminaText'.text = str(str(Playerstats.CurrentStamina),"/",str(Playerstats.MaxStamina))
									
									$'../../Players/Player'.PlayCard(CardInfo[1], 0)
									setup = true
									MovingToDiscard = true
									state = MoveDrawnCardToDiscard
									CARD_SELECT = true
								else:
									setup = true
									targetpos = Cardpos
									state = ReOrganiseHand
									CARD_SELECT = true
						else:
							setup = true
							targetpos = Cardpos
							state = ReOrganiseHand
							CARD_SELECT = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	match state:
		InHand:
			pass
		InMouse:
			#print("InMouse")
			if setup:
				Setup()
			if t <= 1:
				rect_position = startpos.linear_interpolate(get_global_mouse_position() - $'../../'.CardSize/2, t)
				rect_rotation = startrot * (1-t) + 0*t
				rect_scale = startscale * (1-t) + OrigScale*t
				t += delta/float(INMOUSETIME)
			else:
				rect_position = get_global_mouse_position() - $'../../'.CardSize/2
				rect_rotation = 0
		FocusInHand:
			#print("FocusInHand")
			if setup:
				Setup()
			if t <= 1:
				rect_position = startpos.linear_interpolate(targetpos, t)
				rect_rotation = startrot * (1-t) + 0*t
				rect_scale = startscale * (1-t) + OrigScale*ZoomInSize*t
				t += delta/float(ZOOMINTIME)
				if ReorganiseNeighbors:
					ReorganiseNeighbors = false
					NumberCardsHand = $'../../'.NumberCardsHand
					if Card_Numb - 1 >= 0:
						Move_Neighbor_Card(Card_Numb - 1, true, 1)
					if Card_Numb - 2 >= 0:
						Move_Neighbor_Card(Card_Numb - 2, true, 0.25)
					if Card_Numb + 1 <= NumberCardsHand:
						Move_Neighbor_Card(Card_Numb + 1, false, 1)
					if Card_Numb + 2 <= NumberCardsHand:
						Move_Neighbor_Card(Card_Numb + 2, false, 0.25)
			else:
				rect_position = targetpos
				rect_rotation = 0
				rect_scale = OrigScale*ZoomInSize
		MoveDrawnCardToHand:
			#print("MoveDrawnCardToHand")
			if setup:
				Setup()
			if t <= 1:
				rect_position = startpos.linear_interpolate(targetpos, t)
				rect_rotation = startrot * (1-t) + targetrot*t
				rect_scale.x = OrigScale.x * abs(2*t - 1)
				if $Back.visible:
					if t >= 0.5:
						$Back.visible = false
				t += delta/float(DRAWTIME)
			else:
				rect_position = targetpos
				rect_rotation = targetrot
				state = InHand
		ReOrganiseHand:
			#print("ReOrganiseHand")
			if setup:
				Setup()
			if t <= 1:
				if Move_Neighbor_Card_Check:
					Move_Neighbor_Card_Check = false
				rect_position = startpos.linear_interpolate(targetpos, t)
				rect_rotation = startrot * (1-t) + targetrot*t
				rect_scale = startscale * (1-t) + OrigScale*t
				t += delta/float(ORGANISETIME)
				if ReorganiseNeighbors == false:
					ReorganiseNeighbors = true
					if Card_Numb - 1 >= 0:
						Reset_Card(Card_Numb - 1)
					if Card_Numb - 2 >= 0:
						Reset_Card(Card_Numb - 2)
					if Card_Numb + 1 <= NumberCardsHand:
						Reset_Card(Card_Numb + 1)
					if Card_Numb + 2 <= NumberCardsHand:
						Reset_Card(Card_Numb + 2)
			else:
				rect_position = targetpos
				rect_rotation = targetrot
				rect_scale = OrigScale
				state = InHand
		MoveDrawnCardToDiscard:
			#print("MoveDrawnCardToDiscard")
			if MovingToDiscard:
				if setup:
					Setup()
					targetpos = DiscardPile
				if t <= 1:
					rect_position = startpos.linear_interpolate(targetpos, t)
					rect_scale = (startscale * (1-t) + OrigScale*t)
					t += delta/float(DISCARDTIME)
				else:
					#$'../../'.ReParentCard(Card_Numb)
					rect_position = targetpos
					rect_scale = OrigScale
					rect_rotation = 0
					MovingToDiscard = false
					$'../../'.ReParentCard(Card_Numb)
					$'../../'.DiscardCountNum += 1
		MoveHandToDiscard:
			if MovingToDiscard:
				if setup:
					Setup()
					targetpos = DiscardPile
				if t <= 1:
					rect_position = startpos.linear_interpolate(targetpos, t)
					rect_scale = (startscale * (1-t) + OrigScale*t)
					rect_rotation = 0
					t += delta/float(DISCARDTIME)
				else:
					rect_position = targetpos
					rect_scale = OrigScale
					rect_rotation = 0
					MovingToDiscard = false
					$'../../'.ReParentCard(Card_Numb)
					$'../../'.DiscardCountNum += 1
					$'../../..'._handle_states(2)
		Display:
			pass

func Move_Neighbor_Card(CardNumb,Left,Spreadfactor):
	NeighborCard = $'../'.get_child(CardNumb)
	if Left:
		NeighborCard.targetpos = NeighborCard.Cardpos - Spreadfactor*Vector2($'../../'.CardSize.x/2,0)
	else:
		NeighborCard.targetpos = NeighborCard.Cardpos + Spreadfactor*Vector2($'../../'.CardSize.x/2,0)
	NeighborCard.setup = true
	NeighborCard.state = ReOrganiseHand
	NeighborCard.Move_Neighbor_Card_Check = true

func Reset_Card(CardNumb):
	#NeighborCard = $'../'.get_child(Card_Numb)
	if NeighborCard.Move_Neighbor_Card_Check == false:
		NeighborCard = $'../'.get_child(CardNumb)
		
		if NeighborCard.state != FocusInHand:
			NeighborCard.state = ReOrganiseHand
			NeighborCard.targetpos = NeighborCard.Cardpos
			NeighborCard.setup = true

func Setup():
	startpos = rect_position
	startrot = rect_rotation
	startscale = rect_scale
	t = 0
	setup = false

func _on_Focus_mouse_entered():
	match state:
		InHand, ReOrganiseHand:
			setup = true
			#print(str(get_viewport().size.y))
			targetpos.x = Cardpos.x - $'../../'.CardSize.x/2
			#targetpos.y = get_viewport().size.y - (($'../../'.CardSize.y)*ZoomInSize)
			targetpos.y = Cardpos.y - ((($'../../'.CardSize.y)*ZoomInSize)/2)
			#print(str(targetpos.y))
			state = FocusInHand


func _on_Focus_mouse_exited():
	match state:
		FocusInHand:
			setup = true
			targetpos = Cardpos
			state = ReOrganiseHand

func Make_Back_Invisible():
	$Back.visible = false
