extends Node

const QTEManager = preload('res://scripts/qte_manager.gd')
const GameSave = preload('res://resources/game_save.gd')
const PlayerStats = preload('res://resources/player_stats.gd')

var current_scene
var _game_save: GameSave
var player_stats: PlayerStats

enum SKILL_TYPE {
	COMBAT,
	ENDURANCE,
	ANIMAL_HANDLING,
	ACROBATICS,
	DRIVING,
}

enum BODY_TYPE {
	ARM,
	HEAD,
	TORSO,
	BACK,
	LEG,
}

enum RISK_LEVEL {
	LOW = 1,
	MEDIUM = 2,
	HIGH = 3,
}

var job_list = [
	{
		"description": "Get punched in the face",
		"payout": 300,
		"qte_type": QTEManager.TYPE.MASHING, # QTEManager.TYPE.QUICK_PRESS
		"qte_difficulty": QTEManager.DIFFICULTY.EASY,
		"required_skills": [
			{
				"type": SKILL_TYPE.ENDURANCE,
				"value": 2
			}
		],
		"injury_risk_level": RISK_LEVEL.LOW,
		"injury_risk_areas": [
			BODY_TYPE.HEAD
		]
	},
	{
		"description": "Get punched in the face 3 times",
		"payout": 700,
		"qte_type": QTEManager.TYPE.MASHING, # QTEManager.TYPE.QUICK_PRESS
		"qte_difficulty": QTEManager.DIFFICULTY.MEDIUM,
		"required_skills": [
			{
				"type": SKILL_TYPE.ENDURANCE,
				"value": 4
			}
		],
		"injury_risk_level": RISK_LEVEL.MEDIUM,
		"injury_risk_areas": [
			BODY_TYPE.HEAD
		]
	},
	{
		"description": "Ride a Motorcycle over a Ramp",
		"payout": 400,
		"qte_type": QTEManager.TYPE.MASHING,
		"qte_difficulty": QTEManager.DIFFICULTY.EASY,
		"required_skills": [
			{
				"type": SKILL_TYPE.DRIVING,
				"value": 1
			},
			{
				"type": SKILL_TYPE.ACROBATICS,
				"value": 1
			}
		],
		"injury_risk_level": RISK_LEVEL.MEDIUM,
		"injury_risk_areas": [
			BODY_TYPE.BACK
		]
	},
	{
		"description": "Get thrown out of a Moving Vehicle",
		"payout": 600,
		"qte_type": QTEManager.TYPE.MASHING, # QTEManager.TYPE.QUICK_PRESS
		"qte_difficulty": QTEManager.DIFFICULTY.MEDIUM,
		"required_skills": [
			{
				"type": SKILL_TYPE.ENDURANCE,
				"value": 1
			},
			{
				"type": SKILL_TYPE.DRIVING,
				"value": 1
			}
		],
		"injury_risk_level": RISK_LEVEL.LOW,
		"injury_risk_areas": [
			BODY_TYPE.BACK,
			BODY_TYPE.TORSO
		]
	},
	{
		"description": "Fight Scene with Frisky the Chimp",
		"payout": 1000,
		"qte_type": QTEManager.TYPE.SIMON_SAYS,
		"qte_difficulty": QTEManager.DIFFICULTY.MEDIUM,
		"required_skills": [
			{
				"type": SKILL_TYPE.ANIMAL_HANDLING,
				"value": 1
			},
			{
				"type": SKILL_TYPE.COMBAT,
				"value": 1
			}
		],
		"injury_risk_level": RISK_LEVEL.MEDIUM,
		"injury_risk_areas": [
			BODY_TYPE.ARM,
			BODY_TYPE.TORSO
		]
	},
	{
		"description": "Teach Frisky the Chimp to use a Sword",
		"payout": 1200,
		"qte_type": QTEManager.TYPE.MASHING, # QTEManager.TYPE.RHYTHM
		"qte_difficulty": QTEManager.DIFFICULTY.MEDIUM,
		"required_skills": [
			{
				"type": SKILL_TYPE.ANIMAL_HANDLING,
				"value": 1
			},
			{
				"type": SKILL_TYPE.COMBAT,
				"value": 1
			}
		],
		"injury_risk_level": RISK_LEVEL.HIGH,
		"injury_risk_areas": [
			BODY_TYPE.ARM,
			BODY_TYPE.TORSO
		]
	},
	{
		"description": "Be a henchman in a fight scene",
		"payout": 200,
		"qte_type": QTEManager.TYPE.SIMON_SAYS,
		"qte_difficulty": QTEManager.DIFFICULTY.EASY,
		"required_skills": [
			{
				"type": SKILL_TYPE.COMBAT,
				"value": 1
			},
			{
				"type": SKILL_TYPE.ENDURANCE,
				"value": 1
			}
		],
		"injury_risk_level": RISK_LEVEL.LOW,
		"injury_risk_areas": [
			BODY_TYPE.BACK,
			BODY_TYPE.HEAD,
			BODY_TYPE.TORSO
		]
	},
	{
		"description": "Do a backflip over a moving car",
		"payout": 900,
		"qte_type": QTEManager.TYPE.MASHING,
		"qte_difficulty": QTEManager.DIFFICULTY.HARD,
		"required_skills": [
			{
				"type": SKILL_TYPE.ACROBATICS,
				"value": 1
			},
			{
				"type": SKILL_TYPE.DRIVING,
				"value": 1
			}
		],
		"injury_risk_level": RISK_LEVEL.MEDIUM,
		"injury_risk_areas": [
			BODY_TYPE.LEG,
			BODY_TYPE.BACK
		]
	},
	{
		"description": "Do a triple backflip",
		"payout": 400,
		"qte_type": QTEManager.TYPE.MASHING, # QTEManager.TYPE.RHYTHM
		"qte_difficulty": QTEManager.DIFFICULTY.MEDIUM,
		"required_skills": [
			{
				"type": SKILL_TYPE.ACROBATICS,
				"value": 1
			}
		],
		"injury_risk_level": RISK_LEVEL.LOW,
		"injury_risk_areas": [
			BODY_TYPE.LEG,
			BODY_TYPE.BACK
		]
	},
	{
		"description": "Jump from a Helicopter into the water",
		"payout": 1400,
		"qte_type": QTEManager.TYPE.SIMON_SAYS,
		"qte_difficulty": QTEManager.DIFFICULTY.HARD,
		"required_skills": [
			{
				"type": SKILL_TYPE.ENDURANCE,
				"value": 1
			},
			{
				"type": SKILL_TYPE.ACROBATICS,
				"value": 1
			}
		],
		"injury_risk_level": RISK_LEVEL.HIGH,
		"injury_risk_areas": [
			BODY_TYPE.LEG,
			BODY_TYPE.BACK
		]
	},
	{
		"description": "Dodge a flying sword",
		"payout": 800,
		"qte_type": QTEManager.TYPE.MASHING, # QTEManager.TYPE.QUICK_PRESS
		"qte_difficulty": QTEManager.DIFFICULTY.MEDIUM,
		"required_skills": [
			{
				"type": SKILL_TYPE.ACROBATICS,
				"value": 1
			}
		],
		"injury_risk_level": RISK_LEVEL.HIGH,
		"injury_risk_areas": [
			BODY_TYPE.HEAD
		]
	},
	{
		"description": "Hang on edge of building",
		"payout": 900,
		"qte_type": QTEManager.TYPE.MASHING,
		"qte_difficulty": QTEManager.DIFFICULTY.MEDIUM,
		"required_skills": [
			{
				"type": SKILL_TYPE.ENDURANCE,
				"value": 1
			}
		],
		"injury_risk_level": RISK_LEVEL.MEDIUM,
		"injury_risk_areas": [
			"Arms",
			BODY_TYPE.LEG
		]
	},
	{
		"description": "Do a Donut",
		"payout": 200,
		"qte_type": QTEManager.TYPE.SIMON_SAYS,
		"qte_difficulty": QTEManager.DIFFICULTY.EASY,
		"required_skills": [
			{
				"type": SKILL_TYPE.DRIVING,
				"value": 1
			}
		],
		"injury_risk_level": RISK_LEVEL.LOW,
		"injury_risk_areas": [
			BODY_TYPE.TORSO,
			BODY_TYPE.BACK
		]
	},
	{
		"description": "On Fire",
		"payout": 800,
		"qte_type": QTEManager.TYPE.MASHING,
		"qte_difficulty": QTEManager.DIFFICULTY.MEDIUM,
		"required_skills": [
			{
				"type": SKILL_TYPE.ENDURANCE,
				"value": 1
			}
		],
		"injury_risk_level": RISK_LEVEL.HIGH,
		"injury_risk_areas": [
			BODY_TYPE.HEAD
		]
	},
	{
		"description": "Jump a Horse over a pit of flames",
		"payout": 1400,
		"qte_type": QTEManager.TYPE.MASHING, # QTEManager.TYPE.RHYTHM
		"qte_difficulty": "",
		"required_skills": [
			{
				"type": SKILL_TYPE.ANIMAL_HANDLING,
				"value": 1
			},
			{
				"type": SKILL_TYPE.DRIVING,
				"value": 1
			}
		],
		"injury_risk_level": RISK_LEVEL.MEDIUM,
		"injury_risk_areas": [
			BODY_TYPE.BACK
		]
	}
]

func get_player_skill(type: SKILL_TYPE):
	match type:
		SKILL_TYPE.COMBAT:
			return player_stats.combat
		SKILL_TYPE.ENDURANCE:
			return player_stats.endurance
		SKILL_TYPE.ANIMAL_HANDLING:
			return player_stats.animal_handling
		SKILL_TYPE.ACROBATICS:
			return player_stats.acrobatics
		SKILL_TYPE.DRIVING:
			return player_stats.driving
	return 0


func set_player_skill(type: SKILL_TYPE, value: int):
	match type:
		SKILL_TYPE.COMBAT:
			player_stats.combat = value
		SKILL_TYPE.ENDURANCE:
			player_stats.endurance = value
		SKILL_TYPE.ANIMAL_HANDLING:
			player_stats.animal_handling = value
		SKILL_TYPE.ACROBATICS:
			player_stats.acrobatics = value
		SKILL_TYPE.DRIVING:
			player_stats.driving = value


func get_player_body_health(body_part: BODY_TYPE):
	match body_part:
		BODY_TYPE.ARM:
			return player_stats.arm_health
		BODY_TYPE.HEAD:
			return player_stats.head_health
		BODY_TYPE.TORSO:
			return player_stats.torso_health
		BODY_TYPE.BACK:
			return player_stats.back_health
		BODY_TYPE.LEG:
			return player_stats.leg_health


func set_player_body_health(body_part: BODY_TYPE, value: int):
	match body_part:
		BODY_TYPE.ARM:
			player_stats.arm_health = value
		BODY_TYPE.HEAD:
			player_stats.head_health = value
		BODY_TYPE.TORSO:
			player_stats.torso_health = value
		BODY_TYPE.BACK:
			player_stats.back_health = value
		BODY_TYPE.LEG:
			player_stats.leg_health = value


func proceedToNextRound():
	randomizeLifeEvents()
	player_stats.round += 1
	_game_save.write_savegame()


func scene_swapper(scene):
	get_tree().root.remove_child(current_scene)
	get_tree().root.add_child(scene)	
	current_scene.queue_free()
	current_scene = scene


func randomizeLifeEvents():
	pass #A function to generate life events


# Called when the node enters the scene tree for the first time.
func _ready():
	_create_or_load_save()
	current_scene = get_node("/root/Bedroom")
	pass # Replace with function body.


func _create_or_load_save():
	if GameSave.save_exists():
		_game_save = GameSave.load_savegame() as GameSave
	else:
		_game_save = GameSave.new()
		_game_save.player_stats = PlayerStats.new()
		_game_save.write_savegame()
	player_stats = _game_save.player_stats
