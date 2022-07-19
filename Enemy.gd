extends Control

# Declare member variables here. Examples:
var CurrentHealth = 20
var MaxHealth = 20
var move

#Status Effects
var Block = 0
var Rage = 0
var Burn = 0
var Ritual = 0
var Frail = 0
var Weak = 0
var Vulnerable = 0

enum {
	NEUTRAL
	ATTACKING
	BUFFING
	RETURNING
}

var state = NEUTRAL
var t = 0
var origpos = rect_position
var targetpos

onready var EnemyDatabase = preload("res://EnemyScenes/EnemyDatabase.gd")
var EnemyName = 'Demon'
onready var EnemyInfo = EnemyDatabase.DATA[EnemyDatabase.get(EnemyName)]

onready var EnemyImg = str("res://Assets/Enemies/",EnemyInfo[0],".png")

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/ImageContainer/Image.texture = load(EnemyImg)
	#$NamePlate/NameText.text = str(EnemyInfo[0])
	$NameText.text = str(EnemyInfo[0])
	MaxHealth = EnemyInfo[1]
	CurrentHealth = MaxHealth
	
	$VBoxContainer/ImageContainer/Image.scale *= $VBoxContainer/ImageContainer.rect_min_size/$VBoxContainer/ImageContainer/Image.texture.get_size()
	$VBoxContainer/Bar/TextureProgress.value = 100
	$VBoxContainer/Bar/Count/Background/Number.text = str(CurrentHealth)
	
	PickMove()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	match state:
		NEUTRAL:
			pass
		ATTACKING:
			if t <= 1:
				targetpos = $'../../Players/Player'.rect_position
				rect_position = rect_position.linear_interpolate(targetpos, t)
				t += delta/float(0.5)
			else:
				rect_position = targetpos
				t = 0
				state = RETURNING
		BUFFING:
			pass
		RETURNING:
			if t <= 1:
				targetpos = origpos
				rect_position = rect_position.linear_interpolate(targetpos, t)
				t += delta/float(0.5)
			else:
				rect_position = targetpos
				t = 0
				state = NEUTRAL


func ChangeHealth(Number):
	var TrueNum = Number
	if Vulnerable > 0:
		TrueNum = TrueNum * 1.5
	for _i in TrueNum:
		yield(get_tree().create_timer(0.1), "timeout")
		CurrentHealth -= 1
		$VBoxContainer/Bar/TextureProgress.value = 100*CurrentHealth/MaxHealth
		$VBoxContainer/Bar/Count/Background/Number.text = str(CurrentHealth)
		if CurrentHealth <= 0:
			return

func PickMove():
	
	move = EnemyInfo[2][randi() % EnemyInfo[2].size()]
	
	match move:
		"Ignite":
			$DebuffIntent.visible = true
		"Big Attack":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(12)
			else:
				$AttackIntent/AttackText.text = str(12, " + ", Rage)
		"Small Attack":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(6)
			else:
				$AttackIntent/AttackText.text = str(6, " + ", Rage)
		"Big Block":
			$DefendIntent.visible = true
		"Small Block":
			$DefendIntent.visible = true
		"Rage":
			$BuffIntent.visible = true
		"Incantation":
			$BuffIntent.visible = true
		"Dark Strike":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(6)
			else:
				$AttackIntent/AttackText.text = str(6, " + ", Rage)
		"Chomp":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(11)
			else:
				$AttackIntent/AttackText.text = str(11, " + ", Rage)
		"Thrash":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(7)
			else:
				$AttackIntent/AttackText.text = str(7, " + ", Rage)
			$DefendIntent.visible = true
		"Bellow":
			$BuffIntent.visible = true
			$DefendIntent.visible = true
		"Bite": 
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(7)
			else:
				$AttackIntent/AttackText.text = str(7, " + ", Rage)
		"Grow":
			$BuffIntent.visible = true
		"Spit Web":
			$DebuffIntent.visible = true
		"Corrosive Spit":
			$DebuffIntent.visible = true
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(7)
			else:
				$AttackIntent/AttackText.text = str(7, " + ", Rage)
		"Lick":
			$DebuffIntent.visible = true
		"Tackle":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(10)
			else:
				$AttackIntent/AttackText.text = str(10, " + ", Rage)
		"Flame Tackle":
			$DebuffIntent.visible = true
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(8)
			else:
				$AttackIntent/AttackText.text = str(8, " + ", Rage)
		"Drool":
			$DebuffIntent.visible = true
		"Smash":
			$DebuffIntent.visible = true
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(4)
			else:
				$AttackIntent/AttackText.text = str(4, " + ", Rage)
		"Scratch":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(4)
			else:
				$AttackIntent/AttackText.text = str(4, " + ", Rage)
		"Protect":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(6)
			else:
				$AttackIntent/AttackText.text = str(6, " + ", Rage)
			$DefendIntent.visible = true
		"Shield Bash":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(6)
			else:
				$AttackIntent/AttackText.text = str(6, " + ", Rage)
		"Puncture":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(9)
			else:
				$AttackIntent/AttackText.text = str(9, " + ", Rage)
		"Stab":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(12)
			else:
				$AttackIntent/AttackText.text = str(12, " + ", Rage)
		"Rake":
			$DebuffIntent.visible = true
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(7)
			else:
				$AttackIntent/AttackText.text = str(7, " + ", Rage)
		"Entangle":
			$DebuffIntent.visible = true
		"Scrape":
			$DebuffIntent.visible = true
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(9)
			else:
				$AttackIntent/AttackText.text = str(9, " + ", Rage)
		"Double Strike":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(6, " x 2")
			else:
				$AttackIntent/AttackText.text = str("(", 6 , " + ", Rage, ") x 2")
		"Suck":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(10)
			else:
				$AttackIntent/AttackText.text = str(10, " + ", Rage)
			
			$BuffIntent.visible = true
		"Fell":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(18)
			else:
				$AttackIntent/AttackText.text = str(18, " + ", Rage)
			
			$DebuffIntent.visible = true
		"Slam":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(10, " x 2")
			else:
				$AttackIntent/AttackText.text = str("(", 10 , " + ", Rage, ") x 2")
		"Activate":
			$DefendIntent.visible = true
		"Harden":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(10)
			else:
				$AttackIntent/AttackText.text = str(10, " + ", Rage)
			$DefendIntent.visible = true
		"Exploit":
			$DebuffIntent.visible = true
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(10)
			else:
				$AttackIntent/AttackText.text = str(10, " + ", Rage)
		"Chomp":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(7, " x 3")
			else:
				$AttackIntent/AttackText.text = str("(", 7 , " + ", Rage, ") x 3")
		"Spores":
			$DebuffIntent.visible = true
		"Poke":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(5, " x 2")
			else:
				$AttackIntent/AttackText.text = str("(", 5 , " + ", Rage, ") x 2")
		"Zap":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(18)
			else:
				$AttackIntent/AttackText.text = str(18, " + ", Rage)
		"Debilitate":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(12)
			else:
				$AttackIntent/AttackText.text = str(12, " + ", Rage)
			$DebuffIntent.visible = true
		"Drain":
			$DebuffIntent.visible = true
			$BuffIntent.visible = true
		"Hex":
			$DebuffIntent.visible = true
		"Slash":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(12)
			else:
				$AttackIntent/AttackText.text = str(12, " + ", Rage)
		"Fury":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(6, " x 3")
			else:
				$AttackIntent/AttackText.text = str("(", 6 , " + ", Rage, ") x 3")
		"Holdfast":
			$DefendIntent.visible = true
		"Bless":
			$BuffIntent.visible = true
		"Holy Flame":
			$BuffIntent.visible = true
		"Ex Communicate":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(8)
			else:
				$AttackIntent/AttackText.text = str(8, " + ", Rage)
			$DebuffIntent.visible = true
		"Caw":
			$BuffIntent.visible = true
		"Peck":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(1, " x 5")
			else:
				$AttackIntent/AttackText.text = str("(", 1 , " + ", Rage, ") x 5")
		"Swoop":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(12)
			else:
				$AttackIntent/AttackText.text = str(12, " + ", Rage)
		"Headbutt":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(3)
			else:
				$AttackIntent/AttackText.text = str(3, " + ", Rage)
		"Beam":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(9)
			else:
				$AttackIntent/AttackText.text = str(9, " + ", Rage)
		"Bolt":
			$DebuffIntent.visible = true
		"Laser":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(10)
			else:
				$AttackIntent/AttackText.text = str(10, " + ", Rage)
			$DebuffIntent.visible = true
		"Claw":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(15)
			else:
				$AttackIntent/AttackText.text = str(15, " + ", Rage)
		"Stance":
			$BuffIntent.visible = true
			$DefendIntent.visible = true
		"Face Slap":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(12)
			else:
				$AttackIntent/AttackText.text = str(12, " + ", Rage)
			$DebuffIntent.visible = true
		"Taunt":
			$DebuffIntent.visible = true
		"Gloat":
			$BuffIntent.visible = true
		"Execute":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(10, " x 2")
			else:
				$AttackIntent/AttackText.text = str("(", 10 , " + ", Rage, ") x 2")
		"Heavy Slash":
			$AttackIntent.visible = true
			if Rage == 0:
				$AttackIntent/AttackText.text = str(18)
			else:
				$AttackIntent/AttackText.text = str(18, " + ", Rage)
		"Anger":
			$BuffIntent.visible = true

func PlayMove(Move):
	match Move:
		"Ignite":
			UpdateLog(Move)
			state = ATTACKING
			Playerstats.Burn += 3
			$'../../Players/Player/BurnStatus/BurnText'.text = str(Playerstats.Burn)
			$'../../Players/Player/BurnStatus'.visible = true
			$DebuffIntent.visible = false
		"Big Attack":
			UpdateLog(Move)
			var AttackDamage = (12 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (12 + Rage)
				$'../../Players/Player/BlockPlate/BlockText'.text = str(Playerstats.Block)
			else:
				Playerstats.Block = 0
				$'../../Players/Player/BlockPlate/BlockText'.text = str(Playerstats.Block)
				$'../../Players/Player/BlockPlate'.visible = false
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
		"Small Attack":
			UpdateLog(Move)
			var AttackDamage = (6 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (6 + Rage)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
		"Big Block":
			UpdateLog(Move)
			Block += 10
			$BlockPlate/BlockText.text = str(Block)
			$BlockPlate.visible = true
			$DefendIntent.visible = false
		"Small Block":
			UpdateLog(Move)
			Block += 5
			$BlockPlate/BlockText.text = str(Block)
			$BlockPlate.visible = true
			$DefendIntent.visible = false
		"Rage":
			UpdateLog(Move)
			Rage += 2
			$RageStatus/RageText.text = str(Rage)
			$RageStatus.visible = true
			$BuffIntent.visible = false
		"Incantation":
			UpdateLog(Move)
			Ritual += 3
			$RitualStatus/RitualText.text = str(Ritual)
			$RitualStatus.visible = true
			$BuffIntent.visible = false
		"Dark Strike":
			UpdateLog(Move)
			var AttackDamage = (6 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (6 + Rage)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
		"Chomp":
			UpdateLog(Move)
			var AttackDamage = (11 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (11 + Rage)
				$'../../Players/Player/BlockPlate/BlockText'.text = str(Playerstats.Block)
			else:
				Playerstats.Block = 0
				$'../../Players/Player/BlockPlate/BlockText'.text = str(Playerstats.Block)
				$'../../Players/Player/BlockPlate'.visible = false
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
		"Thrash":
			UpdateLog(Move)
			var AttackDamage = (7 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (7 + Rage)
				$'../../Players/Player/BlockPlate/BlockText'.text = str(Playerstats.Block)
			else:
				Playerstats.Block = 0
				$'../../Players/Player/BlockPlate/BlockText'.text = str(Playerstats.Block)
				$'../../Players/Player/BlockPlate'.visible = false
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
			
			Block += 5
			$BlockPlate/BlockText.text = str(Block)
			$BlockPlate.visible = true
			$DefendIntent.visible = false
		"Bellow":
			UpdateLog(Move)
			Rage += 3
			$RageStatus/RageText.text = str(Rage)
			$RageStatus.visible = true
			$BuffIntent.visible = false
			
			Block += 5
			$BlockPlate/BlockText.text = str(Block)
			$BlockPlate.visible = true
			$DefendIntent.visible = false
		"Bite":
			UpdateLog(Move)
			var AttackDamage = (7 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (7 + Rage)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
		"Grow":
			UpdateLog(Move)
			Rage += 3
			$RageStatus/RageText.text = str(Rage)
			$RageStatus.visible = true
			$BuffIntent.visible = false
		"Spit Web":
			UpdateLog(Move)
			state = ATTACKING
			Playerstats.Weak += 3
			$'../../Players/Player/WeakStatus/WeakText'.text = str(Playerstats.Weak)
			$'../../Players/Player/WeakStatus'.visible = true
			$DebuffIntent.visible = false
		"Corrosive Spit":
			UpdateLog(Move)
			var AttackDamage = (7 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (7 + Rage)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
			#Add Slimed Card
			$DebuffIntent.visible = false
		"Lick":
			UpdateLog(Move)
			state = ATTACKING
			Playerstats.Weak += 2
			$'../../Players/Player/WeakStatus/WeakText'.text = str(Playerstats.Weak)
			$'../../Players/Player/WeakStatus'.visible = true
			$DebuffIntent.visible = false
		"Tackle":
			UpdateLog(Move)
			var AttackDamage = (10 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (10 + Rage)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
		"Flame Tackle":
			UpdateLog(Move)
			var AttackDamage = (8 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (8 + Rage)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
			#Add Slimed Card
			$DebuffIntent.visible = false
		"Drool":
			UpdateLog(Move)
			state = ATTACKING
			Playerstats.Frail += 2
			$'../../Players/Player/FrailStatus/FrailText'.text = str(Playerstats.Frail)
			$'../../Players/Player/FrailStatus'.visible = true
		"Smash":
			UpdateLog(Move)
			var AttackDamage = (4 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (4 + Rage)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
			
			Playerstats.Weak += 2
			$'../../Players/Player/WeakStatus/WeakText'.text = str(Playerstats.Weak)
			$'../../Players/Player/WeakStatus'.visible = true
			$DebuffIntent.visible = false
		"Scratch":
			UpdateLog(Move)
			var AttackDamage = (4 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (4 + Rage)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
		"Protect":
			UpdateLog(Move)
			var AttackDamage = (6 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (6 + Rage)
				$'../../Players/Player/BlockPlate/BlockText'.text = str(Playerstats.Block)
			else:
				Playerstats.Block = 0
				$'../../Players/Player/BlockPlate/BlockText'.text = str(Playerstats.Block)
				$'../../Players/Player/BlockPlate'.visible = false
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
			
			Block += 7
			$BlockPlate/BlockText.text = str(Block)
			$BlockPlate.visible = true
			$DefendIntent.visible = false
		"Shield Bash":
			UpdateLog(Move)
			var AttackDamage = (6 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (6 + Rage)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
		"Puncture":
			UpdateLog(Move)
			var AttackDamage = (9 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (9 + Rage)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
		"Stab":
			UpdateLog(Move)
			var AttackDamage = (12 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (12 + Rage)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
		"Rake":
			UpdateLog(Move)
			var AttackDamage = (7 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (7 + Rage)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
			
			Playerstats.Weak += 2
			$'../../Players/Player/WeakStatus/WeakText'.text = str(Playerstats.Weak)
			$'../../Players/Player/WeakStatus'.visible = true
			$DebuffIntent.visible = false
		"Entangle":
			UpdateLog(Move)
			state = ATTACKING
			Playerstats.Entangled += 2
			$'../../Players/Player/EntangledStatus/EntangledText'.text = str(Playerstats.Entangled)
			$'../../Players/Player/EntangledStatus'.visible = true
			$DebuffIntent.visible = false
		"Scrape":
			UpdateLog(Move)
			var AttackDamage = (9 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (9 + Rage)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
			
			Playerstats.Vulnerable += 3
			$'../../Players/Player/VulnerableStatus/VulnerableText'.text = str(Playerstats.Vulnerable)
			$'../../Players/Player/VulnerableStatus'.visible = true
			$DebuffIntent.visible = false
		"Double Strike":
			UpdateLog(Move)
			var AttackDamage = ((6 + Rage) * 2) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= ((6 + Rage) * 2)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
		"Suck":
			UpdateLog(Move)
			var AttackDamage = (10 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (10 + Rage)
				$'../../Players/Player/BlockPlate/BlockText'.text = str(Playerstats.Block)
			else:
				Playerstats.Block = 0
				$'../../Players/Player/BlockPlate/BlockText'.text = str(Playerstats.Block)
				$'../../Players/Player/BlockPlate'.visible = false
				$'../../Players/Player'.ChangeHealth(AttackDamage)
				
				CurrentHealth += AttackDamage
				if CurrentHealth > MaxHealth:
					CurrentHealth = MaxHealth
				$VBoxContainer/Bar/TextureProgress.value = 100*CurrentHealth/MaxHealth
				$VBoxContainer/Bar/Count/Background/Number.text = str(CurrentHealth)
				
			$AttackIntent.visible = false
			$BuffIntent.visible = false
		"Fell":
			UpdateLog(Move)
			var AttackDamage = (18 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (18 + Rage)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
			
			Playerstats.Frail += 3
			$'../../Players/Player/FrailStatus/FrailText'.text = str(Playerstats.Frail)
			$'../../Players/Player/FrailStatus'.visible = true
			$DebuffIntent.visible = false
		"Slam":
			UpdateLog(Move)
			var AttackDamage = ((10 + Rage) * 2) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= ((10 + Rage) * 2)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
		"Activate":
			UpdateLog(Move)
			Block += 25
			$BlockPlate/BlockText.text = str(Block)
			$BlockPlate.visible = true
			$DefendIntent.visible = false
		"Harden":
			UpdateLog(Move)
			var AttackDamage = (10 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (10 + Rage)
				$'../../Players/Player/BlockPlate/BlockText'.text = str(Playerstats.Block)
			else:
				Playerstats.Block = 0
				$'../../Players/Player/BlockPlate/BlockText'.text = str(Playerstats.Block)
				$'../../Players/Player/BlockPlate'.visible = false
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
			
			Block += 15
			$BlockPlate/BlockText.text = str(Block)
			$BlockPlate.visible = true
			$DefendIntent.visible = false
		"Exploit":
			UpdateLog(Move)
			var AttackDamage = (10 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (10 + Rage)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
			
			Playerstats.Frail += 5
			$'../../Players/Player/FrailStatus/FrailText'.text = str(Playerstats.Frail)
			$'../../Players/Player/FrailStatus'.visible = true
			$DebuffIntent.visible = false
		"Chomp":
			UpdateLog(Move)
			var AttackDamage = ((7 + Rage) * 3) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= ((7 + Rage) * 3)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
		"Spores":
			UpdateLog(Move)
			state = ATTACKING
			Playerstats.Frail += 3
			$'../../Players/Player/FrailStatus/FrailText'.text = str(Playerstats.Frail)
			$'../../Players/Player/FrailStatus'.visible = true
			
			Playerstats.Weak += 3
			$'../../Players/Player/WeakStatus/WeakText'.text = str(Playerstats.Weak)
			$'../../Players/Player/WeakStatus'.visible = true
			
			$DebuffIntent.visible = false
		"Poke":
			UpdateLog(Move)
			var AttackDamage = ((5 + Rage) * 2) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= ((5 + Rage) * 2)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
		"Zap":
			UpdateLog(Move)
			var AttackDamage = (18 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (18 + Rage)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
		"Debilitate":
			UpdateLog(Move)
			var AttackDamage = (10 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (10 + Rage)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
			
			Playerstats.Vulnerable += 3
			$'../../Players/Player/VulnerableStatus/VulnerableText'.text = str(Playerstats.Vulnerable)
			$'../../Players/Player/VulnerableStatus'.visible = true
			$DebuffIntent.visible = false
		"Drain":
			UpdateLog(Move)
			state = ATTACKING
			Playerstats.Weak += 4
			$'../../Players/Player/WeakStatus/WeakText'.text = str(Playerstats.Weak)
			$'../../Players/Player/WeakStatus'.visible = true
			$DebuffIntent.visible = false
			
			Rage += 3
			$RageStatus/RageText.text = str(Rage)
			$RageStatus.visible = true
			$BuffIntent.visible = false
		"Hex":
			UpdateLog(Move)
			state = ATTACKING
			Playerstats.Hex += 2
			$'../../Players/Player/HexStatus/HexText'.text = str(Playerstats.Hex)
			$'../../Players/Player/HexStatus'.visible = true
			$DebuffIntent.visible = false
		"Slash":
			UpdateLog(Move)
			var AttackDamage = (12 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (12 + Rage)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
		"Fury":
			UpdateLog(Move)
			var AttackDamage = ((6 + Rage) * 3) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= ((6 + Rage) * 3)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
		"Holdfast":
			UpdateLog(Move)
			Block += 15
			$BlockPlate/BlockText.text = str(Block)
			$BlockPlate.visible = true
			$DefendIntent.visible = false
		"Bless":
			UpdateLog(Move)
			for Enemy in $'../../Enemies'.get_children():
				Enemy.PlayMove("Bless Team")
			$BuffIntent.visible = false
		"Holy Flame":
			UpdateLog(Move)
			for Enemy in $'../../Enemies'.get_children():
				Enemy.PlayMove("Holy Flame Team")
			$BuffIntent.visible = false
		"Ex Communicate":
			UpdateLog(Move)
			var AttackDamage = (8 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (8 + Rage)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
			
			Playerstats.Frail += 3
			$'../../Players/Player/FrailStatus/FrailText'.text = str(Playerstats.Frail)
			$'../../Players/Player/FrailStatus'.visible = true
			$DebuffIntent.visible = false
		"Bless Team":
			CurrentHealth += 16
			if CurrentHealth > MaxHealth:
				CurrentHealth = MaxHealth
			$VBoxContainer/Bar/TextureProgress.value = 100*CurrentHealth/MaxHealth
			$VBoxContainer/Bar/Count/Background/Number.text = str(CurrentHealth)
		"Holy Flame Team":
			Rage += 2
			$RageStatus/RageText.text = str(Rage)
			$RageStatus.visible = true
		"Caw":
			UpdateLog(Move)
			Rage += 2
			$RageStatus/RageText.text = str(Rage)
			$RageStatus.visible = true
			$BuffIntent.visible = false
		"Peck":
			UpdateLog(Move)
			var AttackDamage = ((1 + Rage) * 5) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= ((1 + Rage) * 5)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
		"Swoop":
			UpdateLog(Move)
			var AttackDamage = (12 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (12 + Rage)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
		"Headbutt":
			UpdateLog(Move)
			var AttackDamage = (3 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (3 + Rage)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
		"Beam":
			UpdateLog(Move)
			var AttackDamage = (9 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (9 + Rage)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
		"Bolt":
			UpdateLog(Move)
			#Shuffles 2 Dazed into the discard pile.
			state = ATTACKING
			$DebuffIntent.visible = false
		"Laser":
			UpdateLog(Move)
			var AttackDamage = (10 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (10 + Rage)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$DebuffIntent.visible = false
		"Claw":
			UpdateLog(Move)
			var AttackDamage = (15 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (15 + Rage)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
		"Stance": 
			UpdateLog(Move)
			Rage += 2
			$RageStatus/RageText.text = str(Rage)
			$RageStatus.visible = true
			$BuffIntent.visible = false
			Block += 15
			$BlockPlate/BlockText.text = str(Block)
			$BlockPlate.visible = true
			$DefendIntent.visible = false
		"Face Slap":
			UpdateLog(Move)
			var AttackDamage = (12 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (12 + Rage)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			Playerstats.Frail += 3
			$'../../Players/Player/FrailStatus/FrailText'.text = str(Playerstats.Frail)
			$'../../Players/Player/FrailStatus'.visible = true
			Playerstats.Vulnerable += 3
			$'../../Players/Player/VulnerableStatus/VulnerableText'.text = str(Playerstats.Vulnerable)
			$'../../Players/Player/VulnerableStatus'.visible = true
			$DebuffIntent.visible = false
			$AttackIntent.visible = false
		"Taunt":
			UpdateLog(Move)
			Playerstats.Vulnerable += 3
			$'../../Players/Player/VulnerableStatus/VulnerableText'.text = str(Playerstats.Vulnerable)
			$'../../Players/Player/VulnerableStatus'.visible = true
			Playerstats.Weak += 3
			$'../../Players/Player/WeakStatus/WeakText'.text = str(Playerstats.Weak)
			$'../../Players/Player/WeakStatus'.visible = true
			$DebuffIntent.visible = false
		"Gloat":
			UpdateLog(Move)
			Rage += 4
			$RageStatus/RageText.text = str(Rage)
			$RageStatus.visible = true
			$BuffIntent.visible = false
		"Execute":
			UpdateLog(Move)
			var AttackDamage = ((10 + Rage) * 2) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= ((10 + Rage) * 2)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
		"Heavy Slash":
			UpdateLog(Move)
			var AttackDamage = (18 + Rage) - Playerstats.Block
			state = ATTACKING
			if (AttackDamage <= 0):
				Playerstats.Block -= (18 + Rage)
			else:
				Playerstats.Block = 0
				$'../../Players/Player'.ChangeHealth(AttackDamage)
			$AttackIntent.visible = false
		"Anger":
			UpdateLog(Move)
			Rage += 9
			$RageStatus/RageText.text = str(Rage)
			$RageStatus.visible = true
			$BuffIntent.visible = false
			
			Burn = 0
			$BurnStatus/BurnText.text = str(Burn)
			Frail = 0
			$FrailStatus/FrailText.text = str(Frail)
			Weak = 0
			$WeakStatus/WeakText.text = str(Weak)
			Vulnerable = 0
			$VulnerableStatus/VulnerableText.text = str(Vulnerable)
			$BuffIntent.visible = false

func HandleStatusEffects():
	if Burn > 0:
		ChangeHealth(Burn)
		Burn -= 1
		$BurnStatus/BurnText.text = str(Burn)
		if Burn == 0:
			$BurnStatus.visible = false
	else:
		$BurnStatus.visible = false
	if Ritual > 0:
		Rage += Ritual
		$RageStatus/RageText.text = str(Rage)
		$RageStatus.visible = true
		Ritual -= 1
		$RitualStatus/RitualText.text = str(Ritual)
		if Ritual == 0:
			$RitualStatus.visible = false
	else: 
		$RitualStatus.visible = false
	if Rage > 0:
		Rage -= 1
		$RageStatus/RageText.text = str(Rage)
		if Rage == 0:
			$RageStatus.visible = false
	if Rage < 0:
		Rage += 1
		$RageStatus/RageText.text = str(Rage)
		if Rage == 0:
			$RageStatus.visible = false
	if Weak > 0:
		Weak -= 1
		$WeakStatus/WeakText.text = str(Weak)
		if Weak == 0:
			$WeakStatus.visible = false
	else:
		$WeakStatus.visible = false
	if Frail > 0:
		Frail -= 1
		$FrailStatus/FrailText.text = str(Frail)
		if Frail == 0:
			$FrailStatus.visible = false
	else:
		$FrailStatus.visible = false
	if Vulnerable > 0:
		Vulnerable -= 1
		$VulnerableStatus/VulnerableText.text = str(Vulnerable)
		if Vulnerable == 0:
			$VulnerableStatus.visible = false
	else:
		$VulnerableStatus.visible = false

	
func HandleBlock():
	if EnemyName != "Champ":
		Block = 0
		$BlockPlate/BlockText.text = str(Block)
		$BlockPlate.visible = false

func UpdateVulnerable(amount):
	Vulnerable += amount
	$VulnerableStatus/VulnerableText.text = str(Vulnerable)
	$VulnerableStatus.visible = true

func UpdateWeak(amount):
	Weak += amount
	$WeakStatus/WeakText.text = str(Weak)
	$WeakStatus.visible = true

func UpdateRage(amount):
	Rage += amount
	$RageStatus/RageText.text = str(Rage)
	$RageStatus.visible = true

func UpdateBurn(amount):
	Burn += amount
	$BurnStatus/BurnText.text = str(Burn)
	$BurnStatus.visible = true

func isAttacking():
	if $AttackIntent.visible == true:
		return true
	else:
		return false

func UpdateLog(Move):
	$'../../CombatLog'.text = str(EnemyName," plays ",Move)
	
