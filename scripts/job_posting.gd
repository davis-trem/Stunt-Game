extends GridContainer

const QTEManager = preload('res://scripts/qte_manager.gd')
const QTE_MASHING = preload('res://scenes/qte_mashing.tscn')
const QTE_SIMON_SAYS = preload('res://scenes/qte_simon_says.tscn')

const QTE_TYPE_TO_SCENE = {
	QTEManager.TYPE.MASHING: QTE_MASHING,
	QTEManager.TYPE.SIMON_SAYS: QTE_SIMON_SAYS,
}

@onready var job_request: RichTextLabel = $JobRequest

var job_idx
var qte_type: QTEManager.TYPE
var qte_difficulty: QTEManager.DIFFICULTY
var required_skills
var injury_risk_level
var injury_risk_areas

# Called when the node enters the scene tree for the first time.
func _ready():
	job_request.add_theme_color_override('default_color', _determine_text_color())


func _determine_text_color() -> Color:
	var caution = false
	for required_skill in GameState.job_list[job_idx]['required_skills']:
		var skill_gap = _get_skill_gap(required_skill['type'], required_skill['value'])
		if skill_gap >= 3:
			return Color.RED 
		elif  skill_gap >= 1:
			caution = true
	return Color.YELLOW if caution else Color.WHITE


func _get_skill_gap(type: GameState.SKILL_TYPE, value: int) -> int:
	match type:
		GameState.SKILL_TYPE.ACROBATICS:
			return value - GameState.player_stats.acrobatics
		GameState.SKILL_TYPE.ENDURANCE:
			return value - GameState.player_stats.endurance
		GameState.SKILL_TYPE.COMBAT:
			return value - GameState.player_stats.combat
		GameState.SKILL_TYPE.ANIMAL_HANDLING:
			return value - GameState.player_stats.animal_handling
		GameState.SKILL_TYPE.DRIVING:
			return value - GameState.player_stats.driving
	return 0


func _gui_input(event):
	if  event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var scene = QTE_TYPE_TO_SCENE[qte_type].instantiate()
		scene.job_idx = job_idx
		scene.qte_difficulty = qte_difficulty
		scene.required_skills = required_skills
		scene.injury_risk_level = injury_risk_level
		scene.injury_risk_areas = injury_risk_areas
		GameState.scene_swapper(scene)
		
