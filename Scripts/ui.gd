extends Control

## UI References
@onready var current_phase_label: Label = $CanvasLayer/UI/Label/current_phase
@onready var current_size_label: Label = $CanvasLayer/UI/Label2/current_layout_size
@onready var current_enemies_label: Label = $CanvasLayer/UI/Label3/current_enemies
@onready var board: Node = $"../Board"


@onready var size_input: LineEdit = $CanvasLayer/Options/Size_layout
@onready var enemy_input: LineEdit = $CanvasLayer/Options/Size_enemy

## Variables
var current_phase: String = "Edit":
	set(value):
		current_phase = value
		current_phase_label.text = value

func _ready() -> void:
	current_phase = GameManager.stage
	
	# Optional: Set default values
	size_input.text = "8"
	enemy_input.text = "1000"
	_on_size_layout_text_submitted("8")
	_on_size_enemy_text_submitted("4")

## Called when user presses Enter in Size field
func _on_size_layout_text_submitted(new_text: String) -> void:
	GameManager.size_board = new_text.to_int()
	if GameManager.size_board < 4:
		GameManager.size_board = 4
	elif GameManager.size_board > 1600:
		GameManager.size_board = 1600
	
	current_size_label.text = str(GameManager.size_board)

## Called when user presses Enter in Enemy count field
func _on_size_enemy_text_submitted(new_text: String) -> void:
	var count = new_text.to_int()
	if count < 0:
		count = 0
	elif count > 20:
		count = 20
	
	current_enemies_label.text = str(count)

## Finish / Toggle Phase Button
func _on_finish_pressed() -> void:
	if current_phase == "Edit":
		current_phase = "Combat"
	else:
		current_phase = "Edit"


func _on_new_board_pressed() -> void:
	board._ready()
