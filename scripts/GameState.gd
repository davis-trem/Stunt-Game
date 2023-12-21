extends Node

const QTEManager = preload('res://scripts/qte_manager.gd')
const GameSave = preload('res://resources/game_save.gd')
const PlayerStats = preload('res://resources/player_stats.gd')

var current_scene
var _game_save: GameSave
var player_stats: PlayerStats


var job_list = [
	{
		"id": 1,
		"job_title": "Jump over a shark",
		"job_requirements": "Clear over a shark with a motorcycle",
		"job_payout": 500,
		"qte_type": QTEManager.TYPE.MASHING,
	},
	{
		"id": 2,
		"job_title": "Building Dive",
		"job_requirements": "Dive from a 500ft building",
		"job_payout": 1500,
		"qte_type": QTEManager.TYPE.MASHING,
	},
	{
		"id": 3,
		"job_title": "Fight Scene",
		"job_requirements": "Fight 10 mean",
		"job_payout": 750,
		"qte_type": QTEManager.TYPE.SIMON_SAYS,
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
