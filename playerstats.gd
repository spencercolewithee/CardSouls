extends Node

var world = "World2"

var strength = 5
var dex = 5
var intel = 3
var luck = 10

var healthmax = 30
var health = 20

var armor = 1
var money = 10

#----------------------
var CurrentHealth = 80
var MaxHealth = 80

var CurrentStamina = 3
var MaxStamina = 3

var MaxHandSize = 6
var DrawSize = 5

#Status Effects
var Block = 0
var Rage = 0
var Burn = 0
var Ritual = 0
var Frail = 0
var Weak = 0
var Entangled = 0
var Vulnerable = 0
var Hex = 0

var boss = false
var canEscape = 0

var AllCards = ["Strike", "Stab", "Dodge", "Eliminate", "Bash", "Anger", "BodySlam", "Clash", "Cleave", "Clothesline", "Flex", "HeavyBlade",
 "IronWave", "PommelStrike", "Shrug", "Thunderclap", "TwinStrike", "Greed", "Bloodletting", "Disarm", "Dropkick",
 "Entrench", "Bloodshot", "Inflame", "Intimidate", "Pummel", "Shockwave", "SpotWeakness", "Uppercut", "Whirlwind",
 "Bludgeon", "Impervious", "LimitBreak", "Reaper", "Neutralize", "Acrobatics", "Backflip", "Bane", "DeadlyPoison",
 "DaggerSpray", "DaggerThrow", "Deflect", "PiercingWail", "PoisonedStab", "Slice", "SuckerPunch", "BouncingFlask",
 "Catalyst", "CripplingCloud", "Dash", "HeelHook", "LegSweep", "Skewer", "Terror", "Adrenaline", "DieDieDie",
 "NoxiousFumes", "Barricade", "DemonForm", "Brutality", "AfterImage", "AThousandCuts", "Rupture", "Purify", "Bandage"]

var DebugList = ["Eliminate", "Eliminate", "Eliminate", "Eliminate", "Eliminate", "Eliminate", "Eliminate", "Eliminate", "Eliminate", "Eliminate", "Eliminate"]
var StarterList = ["Strike", "Strike", "Strike", "Strike", "Stab", "Dodge", "Dodge", "Dodge", "Dodge", "Shrug", "Bash", "Neutralize"]

var CardList = [] + StarterList
var CardList1 = [] + CardList
var CardList2 = [] + CardList

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
