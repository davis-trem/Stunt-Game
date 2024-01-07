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

var job_list = [
	{
		"description": "Get punched in the face",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.COMBAT, "value": 0 }
		],
		"risk_areas": [
			BODY_TYPE.HEAD,
		]
	},
	{
		"description": "Punch a dog in the face",
		"payout": 500,
		"qte_type": QTEManager.TYPE.SIMON_SAYS,
		"required_skills": [
			{ "type": SKILL_TYPE.COMBAT, "value": 1 },
			{ "type": SKILL_TYPE.ANIMAL_HANDLING, "value": 1 }
		],
		"risk_areas": [
			BODY_TYPE.ARM,
		]
	},
	{
		"description": "Punch somebody in the face while on a motorcycle",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.COMBAT, "value": 3 },
			{ "type": SKILL_TYPE.DRIVING, "value": 3 }
		],
		"risk_areas": [
			BODY_TYPE.ARM,
			BODY_TYPE.BACK,
			BODY_TYPE.TORSO,
		]
	},
	{
		"description": "Fight a monkey",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.COMBAT, "value": 2 },
			{ "type": SKILL_TYPE.ANIMAL_HANDLING, "value": 4 }
		],
		"risk_areas": [
			BODY_TYPE.ARM,
			BODY_TYPE.HEAD,
		]
	},
	{
		"description": "Fight a monkey with a sword",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.COMBAT, "value": 5 },
			{ "type": SKILL_TYPE.ANIMAL_HANDLING, "value": 4 },
			{ "type": SKILL_TYPE.ACROBATICS, "value": 1 }
		],
		"risk_areas": [
			BODY_TYPE.ARM,
			BODY_TYPE.TORSO,
		]
	},
	{
		"description": "Get your ass kicked by a dog",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.ENDURANCE, "value": 1 },
			{ "type": SKILL_TYPE.ANIMAL_HANDLING, "value": 1 }
		],
		"risk_areas": [
			BODY_TYPE.LEG,
			BODY_TYPE.TORSO,
		]
	},
	{
		"description": "Do a backflip",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.ACROBATICS, "value": 1 }
		],
		"risk_areas": [
			BODY_TYPE.LEG,
			BODY_TYPE.BACK,
		]
	},
	{
		"description": "Do a triple backflip",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.ACROBATICS, "value": 2 }
		],
		"risk_areas": []
	},
	{
		"description": "Do a backflip and kick somebody in the chest",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.ACROBATICS, "value": 3 },
			{ "type": SKILL_TYPE.COMBAT, "value": 2 }
		],
		"risk_areas": []
	},
	{
		"description": "Flying kick a bear in the chest",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.COMBAT, "value": 5 },
			{ "type": SKILL_TYPE.ANIMAL_HANDLING, "value": 5 },
			{ "type": SKILL_TYPE.ENDURANCE, "value": 2 }
		],
		"risk_areas": []
	},
	

	{
		"description": "Outrun a bear",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.ANIMAL_HANDLING, "value": 0 },
			{ "type": SKILL_TYPE.ACROBATICS, "value": 0 }
		],
		"risk_areas": []
	},
	{
		"description": "Outrun a dog",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.ANIMAL_HANDLING, "value": 0 },
			{ "type": SKILL_TYPE.ACROBATICS, "value": 0 }
		],
		"risk_areas": []
	},
	{
		"description": "Outrun a monkey with a sword",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.ANIMAL_HANDLING, "value": 0 },
			{ "type": SKILL_TYPE.ACROBATICS, "value": 0 },
			{ "type": SKILL_TYPE.COMBAT, "value": 0 },
		],
		"risk_areas": []
	},
	{
		"description": "Outrun a motorcycle",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.ACROBATICS, "value": 0 },
			{ "type": SKILL_TYPE.DRIVING, "value": 0 }
		],
		"risk_areas": []
	},
	{
		"description": "Outrun a monkey on a motorcycle with a sword",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.ACROBATICS, "value": 0 },
			{ "type": SKILL_TYPE.DRIVING, "value": 0 },
			{ "type": SKILL_TYPE.COMBAT, "value": 0 }
		],
		"risk_areas": []
	},
	{
		"description": "Throw a dog from a moving train",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.DRIVING, "value": 0 },
			{ "type": SKILL_TYPE.ANIMAL_HANDLING, "value": 0 }
		],
		"risk_areas": []
	},
	{
		"description": "Flying kick a horse from a moving train",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.COMBAT, "value": 0 },
			{ "type": SKILL_TYPE.ANIMAL_HANDLING, "value": 0 },
			{ "type": SKILL_TYPE.DRIVING, "value": 0 }
		],
		"risk_areas": []
	},
	{
		"description": "Backflip over a dog",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.ACROBATICS, "value": 0 },
			{ "type": SKILL_TYPE.ANIMAL_HANDLING, "value": 0 }
		],
		"risk_areas": []
	},
	{
		"description": "Backflip over a horse",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.ACROBATICS, "value": 0 },
			{ "type": SKILL_TYPE.ANIMAL_HANDLING, "value": 0 }
		],
		"risk_areas": []
	},
	{
		"description": "Backflip over a monkey",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.ACROBATICS, "value": 0 },
			{ "type": SKILL_TYPE.ANIMAL_HANDLING, "value": 0 }
		],
		"risk_areas": []
	},
	{
		"description": "Backflip over a monkey with a sword",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.ACROBATICS, "value": 0 },
			{ "type": SKILL_TYPE.COMBAT, "value": 0 },
			{ "type": SKILL_TYPE.ANIMAL_HANDLING, "value": 0 }
		],
		"risk_areas": []
	},
	{
		"description": "Motorcycle on a ramp over a pit of flames",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.DRIVING, "value": 0 },
			{ "type": SKILL_TYPE.ENDURANCE, "value": 0 }
		],
		"risk_areas": []
	},
	{
		"description": "Jump a motorcycle over a family of monkeys",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.DRIVING, "value": 0 },
			{ "type": SKILL_TYPE.ENDURANCE, "value": 0 },
			{ "type": SKILL_TYPE.ANIMAL_HANDLING, "value": 0 }
		],
		"risk_areas": []
	},
	{
		"description": "Outrun a helicopter full of wild dogs",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.ACROBATICS, "value": 0 },
			{ "type": SKILL_TYPE.ANIMAL_HANDLING, "value": 0 },
			{ "type": SKILL_TYPE.DRIVING, "value": 0 }
		],
		"risk_areas": []
	},
	{
		"description": "Get thrown off a building",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.ENDURANCE, "value": 0 }
		],
		"risk_areas": []
	},
	{
		"description": "Get thrown into a pit of flames",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.ENDURANCE, "value": 0 }
		],
		"risk_areas": []
	},
	{
		"description": "Get kicked in the balls",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.ENDURANCE, "value": 0 }
		],
		"risk_areas": []
	},
	{
		"description": "Get kicked in the balls by a horse",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.ENDURANCE, "value": 0 },
			{ "type": SKILL_TYPE.ANIMAL_HANDLING, "value": 0 }
		],
		"risk_areas": []
	},
	{
		"description": "Get kicked in the balls three times",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.ENDURANCE, "value": 0 }
		],
		"risk_areas": []
	},
	{
		"description": "Get Flyin kicked in the face",
		"payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
		"required_skills": [
			{ "type": SKILL_TYPE.ENDURANCE, "value": 0 },
			{ "type": SKILL_TYPE.COMBAT, "value": 0 },
		],
		"risk_areas": []
	},
]

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
