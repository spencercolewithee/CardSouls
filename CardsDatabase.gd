
# Attackinfo = [Type, Name, Rarity, Description, Cost, Damage, Effect, Weapon]
# Skillinfo = [Type, Name, Rarity, Description, Cost, Block, Effect]
# Magicinfo = []
enum {Strike, Stab, Dodge, Eliminate, Bash, Anger, BodySlam, Clash, Cleave, Clothesline, Flex, HeavyBlade,
 IronWave, PommelStrike, Shrug, Thunderclap, TwinStrike, Greed, Bloodletting, Disarm, Dropkick,
 Entrench, Bloodshot, Inflame, Intimidate, Pummel, Shockwave, SpotWeakness, Uppercut, Whirlwind,
 Bludgeon, Impervious, LimitBreak, Reaper, Neutralize, Acrobatics, Backflip, Bane, DeadlyPoison,
 DaggerSpray, DaggerThrow, Deflect, PiercingWail, PoisonedStab, Slice, SuckerPunch, BouncingFlask,
 Catalyst, CripplingCloud, Dash, HeelHook, LegSweep, Skewer, Terror, Adrenaline, DieDieDie, NoxiousFumes,
 Barricade, DemonForm, Brutality, AfterImage, AThousandCuts, Rupture, Purify, Bandage}

const DATA = {
	Strike : 
		["Attack", "Strike", "Grey", "Deal STR+1 Damage.", 1, 6, "None", "Shortsword"],
	Stab :
		["Attack", "Stab", "Diamond", "Deal STR+2 Damage.\n Ignores enemy block.", 2, 8, "Pierce", "Shortsword"],
	Dodge :
		["Skill", "Dodge", "Grey", "Gain DEX+3 Block.", 1, 8, "None"],
	Eliminate :
		["Attack", "Eliminate", "Gold", "Kill the target.", 0, 100, "None", "Shortsword"],
	Bash :
		["Attack", "Bash", "Diamond", "Deal STR+3 Damage. Apply INT Vulnerable.", 2, 8, "None", "Shortsword"],
	Anger :
		["Attack", "Anger", "Grey", "Deal STR+1 damage. Add a copy of this card to your discard pile.", 0, 6, "None", "Shortsword"],
	BodySlam :
		["Attack", "Body Slam", "Grey", "Deal damage equal to your current Block.", 1, 0, "None", "Shortsword"],
	Clash :
		["Attack", "Clash", "Grey", "Can only be played if every card in your hand is an Attack. Deal STR*2 damage.", 0, 14, "None", "Shortsword"],
	Cleave :
		["Attack", "Cleave", "Grey", "Deal STR+5 damage to ALL enemies.", 1, 10, "None", "Shortsword"],
	Clothesline :
		["Attack", "Clothesline", "Grey", "Deal STR+6 damage. Apply INT Weak.", 2, 12, "None", "Shortsword"],
	Flex :
		["Skill", "Flex", "Gold", "Gain INT Rage.", 1, 0, "None"],
	HeavyBlade :
		["Attack", "Heavy Blade", "Diamond", "Deal STR+10 damage. Rage affects Heavy Blade 3 times.", 2, 14, "None", "Shortsword"],
	IronWave :
		["Attack", "Iron Wave", "Grey", "Gain DEX+2 Block. Deal STR+2 damage.", 1, 7, "None", "Shortsword"],
	PommelStrike :
		["Attack", "Pommel Strike", "Grey", "Deal STR+4 damage. Draw 1 card.", 1, 9, "None", "Shortsword"],
	Shrug :
		["Skill", "Shrug", "Diamond", "Gain DEX+3 Block. Draw 1 card.", 1, 8, "None"],
	Thunderclap :
		["Attack", "Thunderclap", "Grey", "Deal STR/2 damage and apply INT Vulnerable to ALL enemies.", 1, 4, "None", "Shortsword"],
	TwinStrike :
		["Attack", "Twin Strike", "Grey", "Deal STR damage twice.", 1, 5, "None", "Shortsword"],
	Greed :
		["Skill", "Greed", "Gold", "Draw 2 Cards.", 0, 0, "None"],
	Bloodletting :
		["Skill", "Bloodletting", "Gold", "Lose 3 HP. Gain 2 Energy.", 0, 0, "None"],
	Disarm :
		["Attack", "Disarm", "Diamond", "Enemy loses INT Rage", 1, 0, "None"],
	Dropkick :
		["Attack", "Dropkick", "Diamond", "Deal STR damage. If the enemy is Vulnerable, gain 1 energy and draw 1 card.", 1, 5, "None", "Shortsword"],
	Entrench :
		["Skill", "Entrench", "Diamond", "Double your current Block.", 2, 0, "None"],
	Bloodshot :
		["Attack", "Bloodshot", "Diamond", "Lose 2 HP. Deal STR*2 damage.", 1, 15, "None", "Shortsword"],
	Inflame :
		["Skill", "Inflame", "Diamond", "Gain INT Rage.", 1, 0, "None"],
	Intimidate :
		["Skill", "Intimidate", "Diamond", "Apply INT Weak to ALL enemies.", 1, 0, "None"],
	Pummel:
		["Attack", "Pummel", "Diamond", "Deal STR/2 damage 5 times.", 1, 0, "None"],
	Shockwave:
		["Skill", "Shockwave", "Diamond", "Apply INT Weak and Vulnerable to ALL enemies.", 2, 0, "None"],
	SpotWeakness:
		["Attack", "Spot Weakness", "Diamond", "If the enemy intends to attack, gain INT Rage.", 1, 0, "None"],
	Uppercut:
		["Attack", "Uppercut", "Diamond", "Deal STR+8 damage. Apply INT/2 Weak. Apply INT/2 Vulnerable.", 2, 0, "None"],
	Whirlwind:
		["Attack", "Whirlwind", "Gold", "Deal STR damage to ALL enemies for each stamina. Lose all stamina.", 0, 0, "None"],
	Bludgeon:
		["Attack", "Bludgeon", "Gold", "Deal STR*4 damage.", 3, 0, "None"],
	Impervious:
		["Skill", "Impervious", "Gold", "Gain DEX*6 Block", 2, 0, "None"],
	LimitBreak:
		["Skill", "Limit Break", "Gold", "Double your Rage.", 1, 0, "None"],
	Reaper:
		["Attack", "Reaper", "Gold", "Deal STR damage to ALL enemies. Heal HP equal to unblocked damage.", 2, 0, "None"],
	Neutralize:
		["Attack", "Neutralize", "Grey", "Deal STR-1 damage. Apply INT Weak.", 0, 0, "None"],
	Acrobatics:
		["Skill", "Acrobatics", "Grey", "Draw 4 cards. Gain DEX/2 Block.", 1, 0, "None"],
	Backflip:
		["Skill", "Backflip", "Grey", "Gain DEX+3 block. Draw 2 cards.", 1, 0, "None"],
	Bane:
		["Attack", "Bane", "Grey", "Deal STR+5 damage. If the enemy is Poisoned, deal STR+5 damage again.", 1, 0, "None"],
	DeadlyPoison:
		["Attack", "Deadly Poison", "Grey", "Apply INT+2 Poison.", 1, 0, "None"],
	DaggerSpray:
		["Skill", "Dagger Spray", "Grey", "Deal STR+1 damage to ALL enemies twice.", 1, 0, "None"],
	DaggerThrow:
		["Attack", "Dagger Throw", "Grey", "Deal STR+7 damage. Draw 1 card.", 1, 0, "None"],
	Deflect:
		["Skill", "Deflect", "Grey", "Gain DEX Block.", 0, 0, "None"],
	PiercingWail:
		["Skill", "Piercing Wail", "Grey", "ALL enemies lose INT+3 Rage", 1, 0, "None"],
	PoisonedStab:
		["Attack", "Poisoned Stab", "Grey", "Deal STR+3 damage. Apply INT Poison.", 1, 0, "None"],
	Slice:
		["Attack", "Slice", "Grey", "Deal STR+4 damage.", 0, 0, "None"],
	SuckerPunch:
		["Attack", "Sucker Punch", "Grey", "Deal STR+4 damage. Apply INT Weak.", 1, 0, "None"],
	BouncingFlask:
		["Skill", "Bouncing Flask", "Diamond", "Apply INT+1 poison to ALL enemies.", 2, 0, "None"],
	Catalyst:
		["Attack", "Catalyst", "Diamond", "Double an enemy's Poison.", 1, 0, "None"],
	CripplingCloud:
		["Skill", "Crippling Cloud", "Diamond", "Apply INT+1 Poison and INT Weak to ALL enemies.", 2, 0, "None"],
	Dash:
		["Attack", "Dash", "Diamond", "Gain DEX*2 Block. Deal STR*2 damage.", 2, 0, "None"],
	HeelHook:
		["Attack", "Heel Hook", "Diamond", "Deal STR+3 damage. If the enemy is Weak, Gain 1 Stamina and draw 1 card.", 1, 0, "None"],
	LegSweep:
		["Skill", "Leg Sweep", "Diamond", "Apply INT Weak to first Enemy. Gain DEX*2 Block.", 2, 0, "None"],
	Skewer:
		["Attack", "Skewer", "Diamond", "Deal STR damage X times.", 0, 0, "None"],
	Terror:
		["Attack", "Terror", "Diamond", "Apply INT+5 Vulnerable.", 2, 0, "None"],
	Adrenaline:
		["Skill", "Adrenaline", "Gold", "Gain 1 Stamina. Draw 2 cards.", 0, 0, "None"],
	DieDieDie:
		["Skill", "Die Die Die", "Gold", "Deal STR*2 damage to ALL enemies.", 1, 0, "None"],
	NoxiousFumes:
		["Spell", "Noxious Fumes", "Gold", "At the start of your turn, apply 2 Poison to ALL enemies.", 2, 0, "None"],
	Barricade:
		["Spell", "Barricade", "Gold", "Block is not removed at the start of your turn.", 3, 0, "None"],
	DemonForm:
		["Spell", "Demon Form", "Gold", "At the start of each turn, gain 2 Rage.", 3, 0, "None"],
	Brutality:
		["Spell", "Brutality", "Gold", "At the start of your turn, lose 1 HP and draw 1 card.", 0, 0, "None"],
	AfterImage:
		["Spell", "After Image", "Gold", "Whenever you play a card, gain 1 Block.", 1, 0, "None"],
	AThousandCuts:
		["Spell", "A Thousand Cuts", "Gold", "Whenever you play a card, deal 1 damage to ALL enemies.", 2, 0, "None"],
	Rupture:
		["Spell", "Rupture", "Gold", "Whenever your HP changes, gain 1 Rage.", 3, 0, "None"],
	Purify:
		["Spell", "Purify", "Diamond", "Remove all debuffs.", 0, 0, "None"],
	Bandage:
		["Spell", "Bandage", "Diamond", "Heal 10 HP", 1, 0, "None"]
	}
