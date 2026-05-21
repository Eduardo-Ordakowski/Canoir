extends CanvasLayer

signal puzzle_solved
signal puzzle_canceled

@onready var slot_operator = $MainContainer/PuzzleArea/SlotOperator
@onready var slot_value = $MainContainer/PuzzleArea/SlotValue

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("ui_cancel"):
		puzzle_canceled.emit()
		queue_free()
		
func _on_resolve_glitch_button_pressed() -> void:
	var is_operator_correct = slot_operator.current_value == "="
	var is_value_correct = slot_value.current_value == "false"
	
	if is_operator_correct and is_value_correct:
		print("Puzzle resolvido")
		puzzle_solved.emit()
		queue_free()
	else:
		print("Puzzle não resolvido")


func _on_close_button_pressed() -> void:
	puzzle_canceled.emit()
	queue_free()
