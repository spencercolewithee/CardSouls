extends Node

export(PackedScene) var target

enum BATTLE_STATES {
	PLAYER,    # When it's time for the player's turn
	ENEMY,    # When it's time for the enemy's turn
	DISCARD,
	WIN,    # When the player wins
	LOSE,    # When the player loses
}

var current_state = BATTLE_STATES.PLAYER

const EnemyBase = preload("res://EnemyScenes/Enemy.tscn")

var EnemyList = ["Demon", "Cultist", "JawWorm", "RedLouse", "GreenLouse", "AcidSlime", "SpikeSlime", "FatGremlin", "MadGremlin", "ShieldGremlin", "SneakyGremlin", "FungiBeast", "BlueSlaver", "RedSlaver", "ShelledParasite", "SphericGuardian", "SnakePlant", "Chosen", "Centurion", "Mystic", "Byrd", "Sentry", "OrbWalker"]
var BackgroundList = ["castle", "coliseum", "crypt", "medieval", "tundra", "hell", "graveyard", "forest"]
var CountList = [1,2,3]

onready var BackgroundImg = str("res://Assets/Background/",BackgroundList[randi() % BackgroundList.size()],".png")

const EnemySize = Vector2(175, 175)

# Called when the node enters the scene tree for the first time.
func _ready():
	Playerstats.CardList1 = [] + Playerstats.CardList
	Playerstats.CardList2 = [] + Playerstats.CardList
	
	$CombatEncounter/STRLabel.text = str("STR = ", Playerstats.strength)
	$CombatEncounter/DEXLabel.text = str("DEX = ", Playerstats.dex)
	$CombatEncounter/INTLabel.text = str("INT = ", Playerstats.intel)
	$CombatEncounter/LCKLabel.text = str("LCK = ", Playerstats.luck)
	
	var EnemyCount = CountList[randi() % CountList.size()]
	$CombatEncounter/BackgroundContainer/Background.texture = load(BackgroundImg)
	
	if Playerstats.boss == true:
		EnemyCount = 1
	
	if EnemyCount == 1:
		var new_enemy = EnemyBase.instance()
		new_enemy.EnemyName = EnemyList[randi() % EnemyList.size()]
		
		if Playerstats.boss == true:
			new_enemy.EnemyName = "Champ"
			
		new_enemy.visible = true
		new_enemy.rect_scale *= EnemySize/new_enemy.rect_size #0.3
		
		if Playerstats.boss == true:
			new_enemy.rect_scale *= 1.5
		
		new_enemy.origpos = Vector2(450, 0)
		new_enemy.rect_position = Vector2(450, 0)
		$CombatEncounter/Enemies.add_child(new_enemy)
		
		$CombatEncounter/Players/Player.visible = true
		$CombatEncounter/Players/Player.rect_scale *= EnemySize/$CombatEncounter/Players/Player.rect_size
		$CombatEncounter/Players/Player.rect_position = Vector2(50, 0)
	elif EnemyCount == 2:
		var new_enemy = EnemyBase.instance()
		new_enemy.EnemyName = EnemyList[randi() % EnemyList.size()]
		new_enemy.visible = true
		new_enemy.rect_scale *= EnemySize/new_enemy.rect_size
		new_enemy.origpos = Vector2(300, 0)
		new_enemy.rect_position = Vector2(300, 0)
		$CombatEncounter/Enemies.add_child(new_enemy)
		
		var new_enemy1 = EnemyBase.instance()
		new_enemy1.EnemyName = EnemyList[randi() % EnemyList.size()]
		new_enemy1.visible = true
		new_enemy1.rect_scale *= EnemySize/new_enemy.rect_size
		new_enemy1.origpos = Vector2(525, 0)
		new_enemy1.rect_position = Vector2(525, 0)
		$CombatEncounter/Enemies.add_child(new_enemy1)
		
		$CombatEncounter/Players/Player.visible = true
		$CombatEncounter/Players/Player.rect_scale *= EnemySize/$CombatEncounter/Players/Player.rect_size
		$CombatEncounter/Players/Player.rect_position = Vector2(0, 0)
	else:
		var new_enemy = EnemyBase.instance()
		new_enemy.EnemyName = EnemyList[randi() % EnemyList.size()]
		new_enemy.visible = true
		new_enemy.rect_scale *= EnemySize/new_enemy.rect_size
		new_enemy.origpos = Vector2(110, 0)
		new_enemy.rect_position = Vector2(110, 0)
		$CombatEncounter/Enemies.add_child(new_enemy)
		
		var new_enemy1 = EnemyBase.instance()
		new_enemy1.EnemyName = EnemyList[randi() % EnemyList.size()]
		new_enemy1.visible = true
		new_enemy1.rect_scale *= EnemySize/new_enemy.rect_size
		new_enemy1.origpos = Vector2(335, 0)
		new_enemy1.rect_position = Vector2(335, 0)
		$CombatEncounter/Enemies.add_child(new_enemy1)
		
		var new_enemy2 = EnemyBase.instance()
		new_enemy2.EnemyName = EnemyList[randi() % EnemyList.size()]
		new_enemy2.visible = true
		new_enemy2.rect_scale *= EnemySize/new_enemy.rect_size
		new_enemy2.origpos = Vector2(550, 0)
		new_enemy2.rect_position = Vector2(550, 0)
		$CombatEncounter/Enemies.add_child(new_enemy2)
		
		$CombatEncounter/Players/Player.visible = true
		$CombatEncounter/Players/Player.rect_scale *= EnemySize/$CombatEncounter/Players/Player.rect_size
		$CombatEncounter/Players/Player.rect_position = Vector2(-120, 0)
	
	_handle_states(current_state)


func _handle_states(new_state):
	current_state = new_state
	
	match current_state:
		BATTLE_STATES.PLAYER:
			$CombatEncounter/CombatLog.text = str("Player Turn")
			
			$CombatEncounter/Players/Player.HandleBlock()
			$CombatEncounter/Players/Player.HandleEntagled()
			$CombatEncounter/Players/Player.HandlePowers()
			
			if Playerstats.CurrentHealth <= 0:
				_handle_states(4)
			
			var won = true
			
			for Enemy in $CombatEncounter/Enemies.get_children():
				if Enemy.CurrentHealth > 0:
					won = false
				else:
					$CombatEncounter/Enemies.remove_child(Enemy)
			
			if (won):
				_handle_states(3)
			else:
				$CombatEncounter/TurnButton.disabled = false
				Playerstats.CurrentStamina = Playerstats.MaxStamina
				$CombatEncounter/Stamina/StaminaText.text = str(str(Playerstats.CurrentStamina),"/",str(Playerstats.MaxStamina))
				$CombatEncounter/Players/Player.HandleStatusEffects()
				
				yield(get_tree().create_timer(0.5), "timeout")
				for _i in range(0,Playerstats.DrawSize):
					$CombatEncounter.draw_card()
					yield(get_tree().create_timer(0.2), "timeout")
				pass
		BATTLE_STATES.ENEMY:
			$CombatEncounter/CombatLog.text = str("Enemy Turn")
			
			for Enemy in $CombatEncounter/Enemies.get_children():
				Enemy.HandleBlock()
#				Enemy.HandleStatusEffects()
			
			if Playerstats.CurrentHealth <= 0:
				_handle_states(4)
				
			var won = true
			
			for Enemy in $CombatEncounter/Enemies.get_children():
				if Enemy.CurrentHealth > 0:
					won = false
				else:
					$CombatEncounter/Enemies.remove_child(Enemy)
			
			
			if (won):
				_handle_states(3)
			else:
				$CombatEncounter/TurnButton.disabled = true
				for Enemy in $CombatEncounter/Enemies.get_children():
					yield(get_tree().create_timer(1), "timeout")
					Enemy.PlayMove(Enemy.move)
					yield(get_tree().create_timer(1), "timeout")
					Enemy.HandleStatusEffects()
					Enemy.PickMove()
				_handle_states(0)
				pass
		BATTLE_STATES.DISCARD:
			$CombatEncounter/CombatLog.text = str("Discard Phase")
			
			if $CombatEncounter/CardEngine.get_child_count() == 0:
				_handle_states(1)
			else:
				var Card = $CombatEncounter/CardEngine.get_children()[0]
				Card.setup = true
				Card.MovingToDiscard = true
				Card.CARD_SELECT = true
				Card.state = 6
			pass
		BATTLE_STATES.WIN:
			if Playerstats.boss == true:
				target = load("res://Victory.tscn")
			next_level()
		BATTLE_STATES.LOSE:
			target = load("res://WinLoseScenes/Lose.tscn")
			next_level()

func next_level():
	var error = get_tree().change_scene_to(target)
	if error != OK:
		print("problem loading next level")


func _on_DeckCount_button_down():
	pass # Replace with function body.
