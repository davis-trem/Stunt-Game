extends Panel

@onready var no_injury_label: Label = $ColorRect/MarginContainer/NoInjuryLabel
@onready var injury_description_container: VBoxContainer = $ColorRect/MarginContainer/InjuryDescriptionContainer
@onready var injury_description_label: Label = $ColorRect/MarginContainer/InjuryDescriptionContainer/InjuryDescriptionLabel

var injured_body_part
var injury_risk_level

const body_part = {
	GameState.BODY_TYPE.ARM: 'Arm',
	GameState.BODY_TYPE.BACK: 'Back',
	GameState.BODY_TYPE.HEAD: 'Head',
	GameState.BODY_TYPE.LEG: 'Leg',
	GameState.BODY_TYPE.TORSO: 'Torso',
}

const severity = {
	GameState.RISK_LEVEL.LOW: 'some what',
	GameState.RISK_LEVEL.MEDIUM: 'pretty',
	GameState.RISK_LEVEL.HIGH: 'severely',
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if injured_body_part == null:
		no_injury_label.show()
	else:
		injury_description_container.show()
		injury_description_label.text = 'Your {0} was {1} injuried (-{2})'.format([
			body_part[injured_body_part],
			severity[injury_risk_level],
			injury_risk_level
		])


func _on_button_pressed() -> void:
	GameState.proceedToNextRound()
	var scene = preload("res://scenes/bedroom.tscn").instantiate()
	GameState.scene_swapper(scene)
