extends MarginContainer

const CardBase = preload("res://CardScenes/AttackBase.tscn")
onready var DeckPosition = $'../../Deck'.position
onready var DiscardPosition = $'../../Discard'.position
const CardSize = Vector2(125, 175)*0.8

#Powers
var fumes = 0
var barr = false
var demon = 0
var brut = 0
var afterimg = 0
var cuts = 0
var rupt = 0

#Stats
var STR = Playerstats.strength
var DEX = Playerstats.dex
var INT = Playerstats.intel
var LCK = Playerstats.luck

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
	$VBoxContainer/ImageContainer/Image.scale *= $VBoxContainer/ImageContainer.rect_min_size/$VBoxContainer/ImageContainer/Image.texture.get_size()
	$VBoxContainer/Bar/TextureProgress.value = 100
	$VBoxContainer/Bar/Count/Background/Number.text = str(Playerstats.CurrentHealth)
	ChangeHealth(Playerstats.MaxHealth - Playerstats.CurrentHealth)
	
	if Playerstats.Rage > 0:
		$RageStatus.visible = false
	if Playerstats.Burn > 0:
		$BurnStatus.visible = false
	if Playerstats.Ritual > 0:
		$RitualStatus.visible = false
	if Playerstats.Frail > 0:
		$FrailStatus.visible = false
	if Playerstats.Weak > 0:
		$WeakStatus.visible = false
	if Playerstats.Entangled > 0:
		$EntangledStatus.visible = false
	if Playerstats.Vulnerable > 0:
		$VulnerableStatus.visible = false
	if Playerstats.Hex > 0:
		$HexStatus.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func ChangeHealth(Number):
	if rupt > 0:
		Playerstats.Rage += rupt
		$RageStatus/RageText.text =  str(Playerstats.Rage)
		if Playerstats.Rage != 0:
			$RageStatus.visible = true
	
	var TrueNum = Number
	if Playerstats.Vulnerable > 0:
		TrueNum = TrueNum * 1.5
	for _i in TrueNum:
		yield(get_tree().create_timer(0.1), "timeout")
		Playerstats.CurrentHealth -= 1
		$VBoxContainer/Bar/TextureProgress.value = 100*(Playerstats.CurrentHealth)/Playerstats.MaxHealth
		$VBoxContainer/Bar/Count/Background/Number.text = str(Playerstats.CurrentHealth)
		
		if Playerstats.CurrentHealth <= 0:
			$'../../../'._handle_states(4)

func PlayCard(card, enemyIndex):
	if Playerstats.Hex > 0:
		ChangeHealth(2)
	
	if afterimg > 0:
		Playerstats.Block += afterimg
		$BlockPlate/BlockText.text = str(Playerstats.Block)
		$BlockPlate.visible = true
	
	if cuts > 0:
		for Enemy in $'../../Enemies'.get_children():
				var AttackDamage = 0
				if Playerstats.Weak > 0:
					AttackDamage = (round(cuts * 0.75)) - Enemy.Block
				else:
					AttackDamage = (cuts) - Enemy.Block
				if (AttackDamage <= 0):
					Enemy.Block -= (cuts)
					Enemy.get_node("BlockPlate/BlockText").text = str(Enemy.Block)
				else:
					Enemy.Block = 0
					Enemy.get_node("BlockPlate/BlockText").text = str(Enemy.Block)
					Enemy.get_node("BlockPlate").visible = false
					Enemy.ChangeHealth(AttackDamage)
		
	match card:
		"Strike":
			var AttackDamage = 0
			if Playerstats.Weak > 0:
				AttackDamage = (round((STR+1) * 0.75) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			else:
				AttackDamage = ((STR+1) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			if (AttackDamage <= 0):
				$'../../Enemies'.get_children()[enemyIndex].Block -= ((STR+1) + Playerstats.Rage)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
			else:
				$'../../Enemies'.get_children()[enemyIndex].Block = 0
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate").visible = false
				$'../../Enemies'.get_children()[enemyIndex].ChangeHealth(AttackDamage)
		"Stab":
			var AttackDamage = 0
			if Playerstats.Weak > 0:
				AttackDamage = (round((STR+2) * 0.75) + Playerstats.Rage)
			else:
				AttackDamage = ((STR+2) + Playerstats.Rage)
			$'../../Enemies'.get_children()[enemyIndex].ChangeHealth(AttackDamage)
		"Dodge":
			if Playerstats.Frail > 0:
				Playerstats.Block += (round((DEX+3) * 0.75))
			else:
				Playerstats.Block += (DEX+3)
			$BlockPlate/BlockText.text = str(Playerstats.Block)
			$BlockPlate.visible = true
				
		"Eliminate":
			var AttackDamage = 0
			if Playerstats.Weak > 0:
				AttackDamage = (round(100 * 0.75) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			else:
				AttackDamage = (100 + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			if (AttackDamage <= 0):
				$'../../Enemies'.get_children()[enemyIndex].Block -= (100 + Playerstats.Rage)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
			else:
				$'../../Enemies'.get_children()[enemyIndex].Block = 0
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate").visible = false
				$'../../Enemies'.get_children()[enemyIndex].ChangeHealth(AttackDamage)
		"Bash":
			var AttackDamage = 0
			if Playerstats.Weak > 0:
				AttackDamage = (round((STR+3) * 0.75) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			else:
				AttackDamage = ((STR+3) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			if (AttackDamage <= 0):
				$'../../Enemies'.get_children()[enemyIndex].Block -= ((STR+3) + Playerstats.Rage)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
			else:
				$'../../Enemies'.get_children()[enemyIndex].Block = 0
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate").visible = false
				$'../../Enemies'.get_children()[enemyIndex].ChangeHealth(AttackDamage)
				
			$'../../Enemies'.get_children()[enemyIndex].UpdateVulnerable(INT)
		"Anger":
			var AttackDamage = 0
			if Playerstats.Weak > 0:
				AttackDamage = (round((STR+1) * 0.75) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			else:
				AttackDamage = ((STR+1) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			if (AttackDamage <= 0):
				$'../../Enemies'.get_children()[enemyIndex].Block -= ((STR+1) + Playerstats.Rage)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
			else:
				$'../../Enemies'.get_children()[enemyIndex].Block = 0
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate").visible = false
				$'../../Enemies'.get_children()[enemyIndex].ChangeHealth(AttackDamage)
				
			Playerstats.CardList2.append("Anger")
		"Body Slam":
			var AttackDamage = 0
			if Playerstats.Weak > 0:
				AttackDamage = (round(Playerstats.Block * 0.75) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			else:
				AttackDamage = (Playerstats.Block + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			if (AttackDamage <= 0):
				$'../../Enemies'.get_children()[enemyIndex].Block -= (Playerstats.Block + Playerstats.Rage)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
			else:
				$'../../Enemies'.get_children()[enemyIndex].Block = 0
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate").visible = false
				$'../../Enemies'.get_children()[enemyIndex].ChangeHealth(AttackDamage)
		"Clash":
			var allAttack = true
				
			for Card in $'../../CardEngine'.get_children():
				if Card.CardInfo[0] != "Attack":
					allAttack = false
			
			if allAttack:
				var AttackDamage = 0
				if Playerstats.Weak > 0:
					AttackDamage = (round((STR*2) * 0.75) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
				else:
					AttackDamage = ((STR*2) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
					
				if (AttackDamage <= 0):
					$'../../Enemies'.get_children()[enemyIndex].Block -= ((STR*2) + Playerstats.Rage)
					$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
				else:
					$'../../Enemies'.get_children()[enemyIndex].Block = 0
					$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
					$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate").visible = false
					$'../../Enemies'.get_children()[enemyIndex].ChangeHealth(AttackDamage)
		"Cleave":
			for Enemy in $'../../Enemies'.get_children():
				var AttackDamage = 0
				if Playerstats.Weak > 0:
					AttackDamage = (round((STR+5) * 0.75) + Playerstats.Rage) - Enemy.Block
				else:
					AttackDamage = ((STR+5) + Playerstats.Rage) - Enemy.Block
				if (AttackDamage <= 0):
					Enemy.Block -= ((STR+5) + Playerstats.Rage)
					Enemy.get_node("BlockPlate/BlockText").text = str(Enemy.Block)
				else:
					Enemy.Block = 0
					Enemy.get_node("BlockPlate/BlockText").text = str(Enemy.Block)
					Enemy.get_node("BlockPlate").visible = false
					Enemy.ChangeHealth(AttackDamage)
		"Clothesline":
			var AttackDamage = 0
			if Playerstats.Weak > 0:
				AttackDamage = (round((STR+6) * 0.75) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			else:
				AttackDamage = ((STR+6) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			if (AttackDamage <= 0):
				$'../../Enemies'.get_children()[enemyIndex].Block -= ((STR+6) + Playerstats.Rage)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
			else:
				$'../../Enemies'.get_children()[enemyIndex].Block = 0
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate").visible = false
				$'../../Enemies'.get_children()[enemyIndex].ChangeHealth(AttackDamage)
				
			$'../../Enemies'.get_children()[enemyIndex].UpdateWeak(INT)
		"Flex":
			Playerstats.Rage += INT
			$RageStatus/RageText.text =  str(Playerstats.Rage)
			$RageStatus.visible = true
		"Heavy Blade":
			var AttackDamage = 0
			if Playerstats.Weak > 0:
				AttackDamage = (round((STR+10) * 0.75) + (Playerstats.Rage * 3)) - $'../../Enemies'.get_children()[enemyIndex].Block
			else:
				AttackDamage = ((STR+10) + (Playerstats.Rage * 3)) - $'../../Enemies'.get_children()[enemyIndex].Block
			if (AttackDamage <= 0):
				$'../../Enemies'.get_children()[enemyIndex].Block -= ((STR+10) + (Playerstats.Rage * 3))
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
			else:
				$'../../Enemies'.get_children()[enemyIndex].Block = 0
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate").visible = false
				$'../../Enemies'.get_children()[enemyIndex].ChangeHealth(AttackDamage)
		"Iron Wave":
			var AttackDamage = 0
			if Playerstats.Weak > 0:
				AttackDamage = (round((STR+2) * 0.75) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			else:
				AttackDamage = ((STR+2) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			if (AttackDamage <= 0):
				$'../../Enemies'.get_children()[enemyIndex].Block -= ((STR+2) + Playerstats.Rage)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
			else:
				$'../../Enemies'.get_children()[enemyIndex].Block = 0
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate").visible = false
				$'../../Enemies'.get_children()[enemyIndex].ChangeHealth(AttackDamage)
			
			if Playerstats.Frail > 0:
				Playerstats.Block += (round((DEX+2) * 0.75))
			else:
				Playerstats.Block += (DEX+2)
			$BlockPlate/BlockText.text = str(Playerstats.Block)
			$BlockPlate.visible = true
		"Pommel Strike":
			var AttackDamage = 0
			if Playerstats.Weak > 0:
				AttackDamage = (round((STR+4) * 0.75) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			else:
				AttackDamage = ((STR+4) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			if (AttackDamage <= 0):
				$'../../Enemies'.get_children()[enemyIndex].Block -= ((STR+4) + Playerstats.Rage)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
			else:
				$'../../Enemies'.get_children()[enemyIndex].Block = 0
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate").visible = false
				$'../../Enemies'.get_children()[enemyIndex].ChangeHealth(AttackDamage)
			
			$'../../'.draw_card()
		"Shrug":
			if Playerstats.Frail > 0:
				Playerstats.Block += (round((DEX+3) * 0.75))
			else:
				Playerstats.Block += (DEX+3)
			$BlockPlate/BlockText.text = str(Playerstats.Block)
			$BlockPlate.visible = true
			
			$'../../'.draw_card()
		"Thunderclap":
			for Enemy in $'../../Enemies'.get_children():
				var AttackDamage = 0
				if Playerstats.Weak > 0:
					AttackDamage = (round((STR/2) * 0.75) + Playerstats.Rage) - Enemy.Block
				else:
					AttackDamage = ((STR/2) + Playerstats.Rage) - Enemy.Block
				if (AttackDamage <= 0):
					Enemy.Block -= ((STR/2) + Playerstats.Rage)
					Enemy.get_node("BlockPlate/BlockText").text = str(Enemy.Block)
				else:
					Enemy.Block = 0
					Enemy.get_node("BlockPlate/BlockText").text = str(Enemy.Block)
					Enemy.get_node("BlockPlate").visible = false
					Enemy.ChangeHealth(AttackDamage)
					
				Enemy.UpdateVulnerable(INT)
		"Twin Strike":
			var AttackDamage = 0
			if Playerstats.Weak > 0:
				AttackDamage = ((round(STR * 0.75) + Playerstats.Rage) * 2) - $'../../Enemies'.get_children()[enemyIndex].Block
			else:
				AttackDamage = ((STR + Playerstats.Rage) * 2) - $'../../Enemies'.get_children()[enemyIndex].Block
			if (AttackDamage <= 0):
				$'../../Enemies'.get_children()[enemyIndex].Block -= ((STR + Playerstats.Rage) * 2)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
			else:
				$'../../Enemies'.get_children()[enemyIndex].Block = 0
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate").visible = false
				$'../../Enemies'.get_children()[enemyIndex].ChangeHealth(AttackDamage)
		"Greed":
			$'../../'.draw_card()
			$'../../'.draw_card()
		"Bloodletting":
			ChangeHealth(3)
			Playerstats.CurrentStamina += 2
			$'../../Stamina/StaminaText'.text = str(Playerstats.CurrentStamina,"/",Playerstats.MaxStamina)
		"Disarm":
			$'../../Enemies'.get_children()[enemyIndex].UpdateRage(-1 * INT)
		"Dropkick":
			var AttackDamage = 0
			if Playerstats.Weak > 0:
				AttackDamage = (round(STR * 0.75) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			else:
				AttackDamage = (STR + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			if (AttackDamage <= 0):
				$'../../Enemies'.get_children()[enemyIndex].Block -= (STR + Playerstats.Rage)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
			else:
				$'../../Enemies'.get_children()[enemyIndex].Block = 0
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate").visible = false
				$'../../Enemies'.get_children()[enemyIndex].ChangeHealth(AttackDamage)
			
			if $'../../Enemies'.get_children()[enemyIndex].Vulnerable > 0:
				$'../../'.draw_card()
				Playerstats.CurrentStamina += 1
				$'../../Stamina/StaminaText'.text = str(Playerstats.CurrentStamina,"/",Playerstats.MaxStamina)
		"Entrench":
			Playerstats.Block += Playerstats.Block
			$BlockPlate/BlockText.text = str(Playerstats.Block)
			$BlockPlate.visible = true
		"Bloodshot":
			ChangeHealth(2)
			
			var AttackDamage = 0
			if Playerstats.Weak > 0:
				AttackDamage = (round((STR*2) * 0.75) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			else:
				AttackDamage = ((STR*2) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			if (AttackDamage <= 0):
				$'../../Enemies'.get_children()[enemyIndex].Block -= ((STR*2) + Playerstats.Rage)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
			else:
				$'../../Enemies'.get_children()[enemyIndex].Block = 0
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate").visible = false
				$'../../Enemies'.get_children()[enemyIndex].ChangeHealth(AttackDamage)
		"Inflame":
			Playerstats.Rage += INT
			$RageStatus/RageText.text = str(Playerstats.Rage)
			$RageStatus.visible = true
		"Intimidate":
			for Enemy in $'../../Enemies'.get_children():
				Enemy.UpdateWeak(INT)
		"Pummel":
			var AttackDamage = 0
			if Playerstats.Weak > 0:
				AttackDamage = ((round((STR/2) * 0.75) + Playerstats.Rage) * 5) - $'../../Enemies'.get_children()[enemyIndex].Block
			else:
				AttackDamage = (((STR/2) + Playerstats.Rage) * 5) - $'../../Enemies'.get_children()[enemyIndex].Block
			if (AttackDamage <= 0):
				$'../../Enemies'.get_children()[enemyIndex].Block -= (((STR/2) + Playerstats.Rage) * 5)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
			else:
				$'../../Enemies'.get_children()[enemyIndex].Block = 0
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate").visible = false
				$'../../Enemies'.get_children()[enemyIndex].ChangeHealth(AttackDamage)
		"Shockwave":
			for Enemy in $'../../Enemies'.get_children():
				Enemy.UpdateWeak(INT)
				Enemy.UpdateVulnerable(INT)
		"Spot Weakness":
			if $'../../Enemies'.get_children()[enemyIndex].isAttacking():
				Playerstats.Rage += INT
				$RageStatus/RageText.text = str(Playerstats.Rage)
				$RageStatus.visible = true
		"Uppercut":
			var AttackDamage = 0
			if Playerstats.Weak > 0:
				AttackDamage = (round((STR+8) * 0.75) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			else:
				AttackDamage = ((STR+8) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			if (AttackDamage <= 0):
				$'../../Enemies'.get_children()[enemyIndex].Block -= ((STR+8) + Playerstats.Rage)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
			else:
				$'../../Enemies'.get_children()[enemyIndex].Block = 0
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate").visible = false
				$'../../Enemies'.get_children()[enemyIndex].ChangeHealth(AttackDamage)
			
			$'../../Enemies'.get_children()[enemyIndex].UpdateWeak(INT/2)
			$'../../Enemies'.get_children()[enemyIndex].UpdateVulnerable(INT/2)
		"Whirlwind":
			for Enemy in $'../../Enemies'.get_children():
				var AttackDamage = 0
				if Playerstats.Weak > 0:
					AttackDamage = ((round(STR * 0.75) + Playerstats.Rage) * Playerstats.CurrentStamina) - Enemy.Block
				else:
					AttackDamage = ((STR + Playerstats.Rage) * Playerstats.CurrentStamina) - Enemy.Block
				if (AttackDamage <= 0):
					Enemy.Block -= ((STR + Playerstats.Rage) * Playerstats.CurrentStamina)
					Enemy.get_node("BlockPlate/BlockText").text = str(Enemy.Block)
				else:
					Enemy.Block = 0
					Enemy.get_node("BlockPlate/BlockText").text = str(Enemy.Block)
					Enemy.get_node("BlockPlate").visible = false
					Enemy.ChangeHealth(AttackDamage)
			
			Playerstats.CurrentStamina = 0
			$'../../Stamina/StaminaText'.text = str(Playerstats.CurrentStamina,"/",Playerstats.MaxStamina)
		"Bludgeon":
			var AttackDamage = 0
			if Playerstats.Weak > 0:
				AttackDamage = (round((STR*4) * 0.75) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			else:
				AttackDamage = ((STR*4) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			if (AttackDamage <= 0):
				$'../../Enemies'.get_children()[enemyIndex].Block -= ((STR*4) + Playerstats.Rage)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
			else:
				$'../../Enemies'.get_children()[enemyIndex].Block = 0
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate").visible = false
				$'../../Enemies'.get_children()[enemyIndex].ChangeHealth(AttackDamage)
		"Impervious":
			if Playerstats.Frail > 0:
				Playerstats.Block += (round((DEX*6) * 0.75))
			else:
				Playerstats.Block += (DEX*6)
			$BlockPlate/BlockText.text = str(Playerstats.Block)
			$BlockPlate.visible = true
		"Limit Break":
			Playerstats.Rage += Playerstats.Rage
			$RageStatus/RageText.text = str(Playerstats.Rage)
			if Playerstats.Rage != 0:
				$RageStatus.visible = true
		"Reaper":
			var unblockedDamage = 0
			
			for Enemy in $'../../Enemies'.get_children():
				var AttackDamage = 0
				if Playerstats.Weak > 0:
					AttackDamage = (round(STR * 0.75) + Playerstats.Rage) - Enemy.Block
				else:
					AttackDamage = (STR + Playerstats.Rage) - Enemy.Block
				if (AttackDamage <= 0):
					Enemy.Block -= (STR + Playerstats.Rage)
					Enemy.get_node("BlockPlate/BlockText").text = str(Enemy.Block)
				else:
					Enemy.Block = 0
					Enemy.get_node("BlockPlate/BlockText").text = str(Enemy.Block)
					Enemy.get_node("BlockPlate").visible = false
					unblockedDamage  += AttackDamage
					Enemy.ChangeHealth(AttackDamage)
			
			Playerstats.CurrentHealth += unblockedDamage
			if Playerstats.CurrentHealth > Playerstats.MaxHealth:
				Playerstats.CurrentHealth = Playerstats.MaxHealth
			$VBoxContainer/Bar/TextureProgress.value = 100*(Playerstats.CurrentHealth)/Playerstats.MaxHealth
			$VBoxContainer/Bar/Count/Background/Number.text = str(Playerstats.CurrentHealth)
		"Neutralize":
			var AttackDamage = 0
			if Playerstats.Weak > 0:
				AttackDamage = (round((STR-1) * 0.75) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			else:
				AttackDamage = ((STR-1) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			if (AttackDamage <= 0):
				$'../../Enemies'.get_children()[enemyIndex].Block -= ((STR-1) + Playerstats.Rage)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
			else:
				$'../../Enemies'.get_children()[enemyIndex].Block = 0
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate").visible = false
				$'../../Enemies'.get_children()[enemyIndex].ChangeHealth(AttackDamage)
			$'../../Enemies'.get_children()[enemyIndex].UpdateWeak(INT)
		"Acrobatics":
			$'../../'.draw_card()
			$'../../'.draw_card()
			$'../../'.draw_card()
			$'../../'.draw_card()
			
			if Playerstats.Frail > 0:
				Playerstats.Block += (round((DEX/2) * 0.75))
			else:
				Playerstats.Block += (DEX/2)
			$BlockPlate/BlockText.text = str(Playerstats.Block)
			$BlockPlate.visible = true
		"Backflip":
			$'../../'.draw_card()
			$'../../'.draw_card()
			
			if Playerstats.Frail > 0:
				Playerstats.Block += (round((DEX+3) * 0.75))
			else:
				Playerstats.Block += (DEX+3)
			$BlockPlate/BlockText.text = str(Playerstats.Block)
			$BlockPlate.visible = true
		"Bane":
			if $'../../Enemies'.get_children()[enemyIndex].Burn > 0:
				var AttackDamage = 0
				if Playerstats.Weak > 0:
					AttackDamage = ((round((STR+5) * 0.75) + Playerstats.Rage) * 2) - $'../../Enemies'.get_children()[enemyIndex].Block
				else:
					AttackDamage = (((STR+5) + Playerstats.Rage) * 2) - $'../../Enemies'.get_children()[enemyIndex].Block
				if (AttackDamage <= 0):
					$'../../Enemies'.get_children()[enemyIndex].Block -= (((STR+5) + Playerstats.Rage) * 2)
					$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
				else:
					$'../../Enemies'.get_children()[enemyIndex].Block = 0
					$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
					$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate").visible = false
					$'../../Enemies'.get_children()[enemyIndex].ChangeHealth(AttackDamage)
			else:
				var AttackDamage = 0
				if Playerstats.Weak > 0:
					AttackDamage = ((round((STR+5) * 0.75) + Playerstats.Rage)) - $'../../Enemies'.get_children()[enemyIndex].Block
				else:
					AttackDamage = (((STR+5) + Playerstats.Rage)) - $'../../Enemies'.get_children()[enemyIndex].Block
				if (AttackDamage <= 0):
					$'../../Enemies'.get_children()[enemyIndex].Block -= (((STR+5) + Playerstats.Rage))
					$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
				else:
					$'../../Enemies'.get_children()[enemyIndex].Block = 0
					$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
					$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate").visible = false
					$'../../Enemies'.get_children()[enemyIndex].ChangeHealth(AttackDamage)
		"Deadly Poison":
			$'../../Enemies'.get_children()[enemyIndex].UpdateBurn(INT+2)
		"Dagger Spray":
			for Enemy in $'../../Enemies'.get_children():
				var AttackDamage = 0
				if Playerstats.Weak > 0:
					AttackDamage = (round((STR+1) * 0.75) + Playerstats.Rage) * 2 - Enemy.Block
				else:
					AttackDamage = ((STR+1) + Playerstats.Rage) * 2 - Enemy.Block
				if (AttackDamage <= 0):
					Enemy.Block -= ((STR+1) + Playerstats.Rage) * 2
					Enemy.get_node("BlockPlate/BlockText").text = str(Enemy.Block)
				else:
					Enemy.Block = 0
					Enemy.get_node("BlockPlate/BlockText").text = str(Enemy.Block)
					Enemy.get_node("BlockPlate").visible = false
					Enemy.ChangeHealth(AttackDamage)
		"Dagger Throw":
			$'../../'.draw_card()
			
			var AttackDamage = 0
			if Playerstats.Weak > 0:
				AttackDamage = (round((STR+7) * 0.75) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			else:
				AttackDamage = ((STR+7) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			if (AttackDamage <= 0):
				$'../../Enemies'.get_children()[enemyIndex].Block -= ((STR+7) + Playerstats.Rage)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
			else:
				$'../../Enemies'.get_children()[enemyIndex].Block = 0
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate").visible = false
				$'../../Enemies'.get_children()[enemyIndex].ChangeHealth(AttackDamage)
		"Deflect":
			if Playerstats.Frail > 0:
				Playerstats.Block += (round(DEX * 0.75))
			else:
				Playerstats.Block += DEX
			$BlockPlate/BlockText.text = str(Playerstats.Block)
			$BlockPlate.visible = true
		"Piercing Wail":
			for Enemy in $'../../Enemies'.get_children():
				Enemy.UpdateRage(-1 * (INT*3))
		"Poisoned Stab":
			$'../../Enemies'.get_children()[enemyIndex].UpdateBurn(INT)
			
			var AttackDamage = 0
			if Playerstats.Weak > 0:
				AttackDamage = (round((STR+3) * 0.75) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			else:
				AttackDamage = ((STR+3) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			if (AttackDamage <= 0):
				$'../../Enemies'.get_children()[enemyIndex].Block -= ((STR+3) + Playerstats.Rage)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
			else:
				$'../../Enemies'.get_children()[enemyIndex].Block = 0
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate").visible = false
				$'../../Enemies'.get_children()[enemyIndex].ChangeHealth(AttackDamage)
		"Slice":
			var AttackDamage = 0
			if Playerstats.Weak > 0:
				AttackDamage = (round((STR+4) * 0.75) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			else:
				AttackDamage = ((STR+4) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			if (AttackDamage <= 0):
				$'../../Enemies'.get_children()[enemyIndex].Block -= ((STR+4) + Playerstats.Rage)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
			else:
				$'../../Enemies'.get_children()[enemyIndex].Block = 0
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate").visible = false
				$'../../Enemies'.get_children()[enemyIndex].ChangeHealth(AttackDamage)
		"Sucker Punch":
			$'../../Enemies'.get_children()[enemyIndex].UpdateWeak(INT)
			
			var AttackDamage = 0
			if Playerstats.Weak > 0:
				AttackDamage = (round((STR+4) * 0.75) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			else:
				AttackDamage = ((STR+4) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			if (AttackDamage <= 0):
				$'../../Enemies'.get_children()[enemyIndex].Block -= ((STR+4) + Playerstats.Rage)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
			else:
				$'../../Enemies'.get_children()[enemyIndex].Block = 0
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate").visible = false
				$'../../Enemies'.get_children()[enemyIndex].ChangeHealth(AttackDamage)
		"Bouncing Flask":
			for Enemy in $'../../Enemies'.get_children():
				Enemy.UpdateBurn(INT+1)
		"Catalyst":
			$'../../Enemies'.get_children()[enemyIndex].UpdateBurn($'../../Enemies'.get_children()[enemyIndex].Burn)
		"Crippling Cloud":
			for Enemy in $'../../Enemies'.get_children():
				Enemy.UpdateBurn(INT+1)
				Enemy.UpdateWeak(INT)
		"Dash":
			var AttackDamage = 0
			if Playerstats.Weak > 0:
				AttackDamage = (round((STR*2) * 0.75) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			else:
				AttackDamage = ((STR*2) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			if (AttackDamage <= 0):
				$'../../Enemies'.get_children()[enemyIndex].Block -= ((STR*2) + Playerstats.Rage)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
			else:
				$'../../Enemies'.get_children()[enemyIndex].Block = 0
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate").visible = false
				$'../../Enemies'.get_children()[enemyIndex].ChangeHealth(AttackDamage)
				
			if Playerstats.Frail > 0:
				Playerstats.Block += (round((DEX*2) * 0.75))
			else:
				Playerstats.Block += (DEX*2)
			$BlockPlate/BlockText.text = str(Playerstats.Block)
			$BlockPlate.visible = true
		"Heel Hook":
			var AttackDamage = 0
			if Playerstats.Weak > 0:
				AttackDamage = (round((STR+3) * 0.75) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			else:
				AttackDamage = ((STR+3) + Playerstats.Rage) - $'../../Enemies'.get_children()[enemyIndex].Block
			if (AttackDamage <= 0):
				$'../../Enemies'.get_children()[enemyIndex].Block -= ((STR+3) + Playerstats.Rage)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
			else:
				$'../../Enemies'.get_children()[enemyIndex].Block = 0
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate").visible = false
				$'../../Enemies'.get_children()[enemyIndex].ChangeHealth(AttackDamage)
			
			if $'../../Enemies'.get_children()[enemyIndex].Weak > 1:
				$'../../'.draw_card()
				Playerstats.CurrentStamina += 1
			$'../../Stamina/StaminaText'.text = str(Playerstats.CurrentStamina,"/",Playerstats.MaxStamina)
		"Leg Sweep":
			if Playerstats.Frail > 0:
				Playerstats.Block += (round((DEX*2) * 0.75))
			else:
				Playerstats.Block += (DEX*2)
			$BlockPlate/BlockText.text = str(Playerstats.Block)
			$BlockPlate.visible = true
			
			$'../../Enemies'.get_children()[0].UpdateWeak(INT)
		"Skewer":
			var AttackDamage = 0
			if Playerstats.Weak > 0:
				AttackDamage = (round(STR * 0.75) + Playerstats.Rage) * Playerstats.CurrentStamina - $'../../Enemies'.get_children()[enemyIndex].Block
			else:
				AttackDamage = (STR + Playerstats.Rage) * Playerstats.CurrentStamina - $'../../Enemies'.get_children()[enemyIndex].Block
			if (AttackDamage <= 0):
				$'../../Enemies'.get_children()[enemyIndex].Block -= (STR + Playerstats.Rage) * Playerstats.CurrentStamina
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
			else:
				$'../../Enemies'.get_children()[enemyIndex].Block = 0
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate/BlockText").text = str($'../../Enemies'.get_children()[enemyIndex].Block)
				$'../../Enemies'.get_children()[enemyIndex].get_node("BlockPlate").visible = false
				$'../../Enemies'.get_children()[enemyIndex].ChangeHealth(AttackDamage)
			
			Playerstats.CurrentStamina = 0
			$'../../Stamina/StaminaText'.text = str(Playerstats.CurrentStamina,"/",Playerstats.MaxStamina)
		"Terror":
			$'../../Enemies'.get_children()[0].UpdateVulnerable(INT+5)
		"Adrenaline":
			Playerstats.CurrentStamina += 1
			$'../../Stamina/StaminaText'.text = str(Playerstats.CurrentStamina,"/",Playerstats.MaxStamina)
			$'../../'.draw_card()
			$'../../'.draw_card()
		"Die Die Die":
			for Enemy in $'../../Enemies'.get_children():
				var AttackDamage = 0
				if Playerstats.Weak > 0:
					AttackDamage = (round((STR*2) * 0.75) + Playerstats.Rage) - Enemy.Block
				else:
					AttackDamage = ((STR*2) + Playerstats.Rage) - Enemy.Block
				if (AttackDamage <= 0):
					Enemy.Block -= ((STR*2) + Playerstats.Rage)
					Enemy.get_node("BlockPlate/BlockText").text = str(Enemy.Block)
				else:
					Enemy.Block = 0
					Enemy.get_node("BlockPlate/BlockText").text = str(Enemy.Block)
					Enemy.get_node("BlockPlate").visible = false
					Enemy.ChangeHealth(AttackDamage)
		"Noxious Fumes":
			fumes += 1
		"Barricade":
			barr = true
		"Demon Form":
			demon += 1
		"Brutality":
			brut += 1
		"After Image":
			afterimg += 1
		"A Thousand Cuts":
			cuts += 1
		"Rupture":
			rupt += 1
		"Purify":
			Playerstats.Burn = 0
			$BurnStatus/BurnText.text = str(Playerstats.Burn)
			Playerstats.Frail = 0
			$FrailStatus/FrailText.text = str(Playerstats.Frail)
			Playerstats.Weak = 0
			$WeakStatus/WeakText.text = str(Playerstats.Weak)
			Playerstats.Entangled = 0
			$EntangledStatus/EntangledText.text = str(Playerstats.Entangled)
			Playerstats.Vulnerable = 0
			$VulnerableStatus/VulnerableText.text = str(Playerstats.Vulnerable)
			Playerstats.Hex = 0
			$HexStatus/HexText.text = str(Playerstats.Hex)
		"Bandage":
			Playerstats.CurrentHealth += 10
			if Playerstats.CurrentHealth > Playerstats.MaxHealth:
				Playerstats.CurrentHealth = Playerstats.MaxHealth
			$VBoxContainer/Bar/TextureProgress.value = 100*(Playerstats.CurrentHealth)/Playerstats.MaxHealth
			$VBoxContainer/Bar/Count/Background/Number.text = str(Playerstats.CurrentHealth)


func HandleStatusEffects():
	if Playerstats.Burn > 0:
		ChangeHealth(Playerstats.Burn)
		Playerstats.Burn -= 1
		$BurnStatus/BurnText.text = str(Playerstats.Burn)
		if Playerstats.Burn == 0:
			$BurnStatus.visible = false
	else:
		$BurnStatus.visible = false
	if Playerstats.Ritual > 0:
		Playerstats.Rage += Playerstats.Ritual
		$RageStatus/RageText.text = str(Playerstats.Rage)
		$RageStatus.visible = true
		Playerstats.Ritual -= 1
		$RitualStatus/RitualText.text = str(Playerstats.Ritual)
		if Playerstats.Ritual == 0:
			$RitualStatus.visible = false
	else: 
		$RitualStatus.visible = false
	if Playerstats.Rage > 0:
		Playerstats.Rage -= 1
		$RageStatus/RageText.text = str(Playerstats.Rage)
		if Playerstats.Rage == 0:
			$RageStatus.visible = false
	else:
		$RageStatus.visible = false
	if Playerstats.Weak > 0:
		Playerstats.Weak -= 1
		$WeakStatus/WeakText.text = str(Playerstats.Weak)
		if Playerstats.Weak == 0:
			$WeakStatus.visible = false
	else:
		$WeakStatus.visible = false
	if Playerstats.Frail > 0:
		Playerstats.Frail -= 1
		$FrailStatus/FrailText.text = str(Playerstats.Frail)
		if Playerstats.Frail == 0:
			$FrailStatus.visible = false
	else:
		$FrailStatus.visible = false
	if Playerstats.Entangled > 0:
		Playerstats.Entangled -= 1
		$EntangledStatus/EntangledText.text = str(Playerstats.Entangled)
		if Playerstats.Entangled == 0:
			$EntangledStatus.visible = false
	else:
		$EntangledStatus.visible = false
	if Playerstats.Vulnerable > 0:
		Playerstats.Vulnerable -= 1
		$VulnerableStatus/VulnerableText.text = str(Playerstats.Vulnerable)
		if Playerstats.Vulnerable == 0:
			$VulnerableStatus.visible = false
	else:
		$VulnerableStatus.visible = false
	if Playerstats.Hex > 0:
		Playerstats.Hex -= 1
		$HexStatus/HexText.text = str(Playerstats.Hex)
		if Playerstats.Hex == 0:
			$HexStatus.visible = false
	else:
		$HexStatus.visible = false

func HandleBlock():
	if !barr:
		Playerstats.Block = 0
		$BlockPlate/BlockText.text = str(Playerstats.Block)
		$BlockPlate.visible = false

func HandlePowers():
	if fumes > 0:
		for Enemy in $'../../Enemies'.get_children():
			Enemy.UpdateBurn(2 * fumes)
	if demon > 0:
		Playerstats.Rage += 2 * demon
		$RageStatus/RageText.text =  str(Playerstats.Rage)
		if Playerstats.Rage != 0:
			$RageStatus.visible = true
	if brut > 0:
		for i in brut:
			ChangeHealth(1)
			$'../../'.draw_card()
		
func HandleEntagled():
	if Playerstats.Entangled > 0:
		Playerstats.CurrentStamina -= 1
		$'../../Stamina/StaminaText'.text = str(Playerstats.CurrentStamina,"/",Playerstats.MaxStamina)
