extends Node

@onready var job_list_container: TextureRect = $JobListContainer
@onready var money_amount: Label = $MoneyAmount
@onready var head_progress_bar: ProgressBar = $Stats/MarginContainer/VBoxContainer/GridContainer/HeadProgressBar
@onready var arm_progress_bar: ProgressBar = $Stats/MarginContainer/VBoxContainer/GridContainer/ArmProgressBar
@onready var torso_progress_bar: ProgressBar = $Stats/MarginContainer/VBoxContainer/GridContainer/TorsoProgressBar
@onready var back_progress_bar: ProgressBar = $Stats/MarginContainer/VBoxContainer/GridContainer/BackProgressBar
@onready var leg_progress_bar: ProgressBar = $Stats/MarginContainer/VBoxContainer/GridContainer/LegProgressBar
@onready var combat_progress_bar: ProgressBar = $Stats/MarginContainer/VBoxContainer/GridContainer2/CombatProgressBar
@onready var endurance_progress_bar: ProgressBar = $Stats/MarginContainer/VBoxContainer/GridContainer2/EnduranceProgressBar
@onready var animal_handling_progress_bar: ProgressBar = $Stats/MarginContainer/VBoxContainer/GridContainer2/AnimalHandlingProgressBar
@onready var acrobatics_progress_bar: ProgressBar = $Stats/MarginContainer/VBoxContainer/GridContainer2/AcrobaticsProgressBar
@onready var driving_progress_bar: ProgressBar = $Stats/MarginContainer/VBoxContainer/GridContainer2/DrivingProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	money_amount.text = "Money $" + str(GameState.player_stats.money)
	
	head_progress_bar.value = GameState.player_stats.head_health
	arm_progress_bar.value = GameState.player_stats.arm_health
	torso_progress_bar.value = GameState.player_stats.torso_health
	back_progress_bar.value = GameState.player_stats.back_health
	leg_progress_bar.value = GameState.player_stats.leg_health
	
	combat_progress_bar.value = GameState.player_stats.combat
	endurance_progress_bar.value = GameState.player_stats.endurance
	animal_handling_progress_bar.value = GameState.player_stats.animal_handling
	acrobatics_progress_bar.value = GameState.player_stats.acrobatics
	driving_progress_bar.value = GameState.player_stats.driving


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_display_job_button_pressed() -> void:
	job_list_container.show()
