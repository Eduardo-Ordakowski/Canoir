extends CanvasLayer

signal puzzle_solved
signal puzzle_canceled

@onready var slot_value = $MainContainer/PuzzleArea/SlotValue
@onready var draggable_get_origin = $MainContainer/InventoryArea/SyntGetOrigin

func _ready() -> void:
	
	if GameManager.get_origin_unlocked:
		draggable_get_origin.show()
	else:
		draggable_get_origin.hide()

func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		puzzle_canceled.emit()
		queue_free()
		
func _on_resolve_glitch_button_pressed() -> void:
	var is_value_correct = slot_value.current_value.to_lower() == "get_origin()"
	
	if is_value_correct:
		GameManager.solved_glitches += 1
		GameManager.canoar_unlocked = true
		print("Puzzle resolvido")
		print(GameManager.solved_glitches)
		puzzle_solved.emit()
		queue_free()
	else:
		GameManager.shake_screen()
		print("Puzzle não resolvido")

func _on_close_button_pressed() -> void:
	puzzle_canceled.emit()
	queue_free()
