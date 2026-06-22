extends CanvasLayer

signal puzzle_solved
signal puzzle_canceled

@onready var slot_value = $MainContainer/PuzzleArea/SlotValue
@onready var draggable_override = $MainContainer/InventoryArea/SyntOverride

func _ready() -> void:
	
	GameManager.tutorial_door_clue.emit();
	if GameManager.founded_sintax_override:
		draggable_override.show()
		$TutorialLabel2.show()
	else:
		draggable_override.hide()
		$TutorialLabel2.hide()

func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		puzzle_canceled.emit()
		queue_free()
		
func _on_resolve_glitch_button_pressed() -> void:
	var is_value_correct = slot_value.current_value.to_lower() == "override"
	
	if is_value_correct:
		print("Puzzle resolvido")
		puzzle_solved.emit()
		queue_free()
	else:
		print("Puzzle não resolvido")

func _on_close_button_pressed() -> void:
	puzzle_canceled.emit()
	queue_free()
