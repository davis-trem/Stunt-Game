class_name GameSave
extends Resource

const PlayerStats = preload('res://resources/player_stats.gd')

const GAME_SAVE_PATH = 'user://save.tres'

@export var player_stats: PlayerStats

func write_savegame():
	ResourceSaver.save(self, GAME_SAVE_PATH)


static func save_exists() -> bool:
	return ResourceLoader.exists(GAME_SAVE_PATH)


static func load_savegame() -> GameSave:
	return ResourceLoader.load(GAME_SAVE_PATH, '', ResourceLoader.CACHE_MODE_IGNORE)
