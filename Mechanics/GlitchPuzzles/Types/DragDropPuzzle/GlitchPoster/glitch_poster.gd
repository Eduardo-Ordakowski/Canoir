extends CanvasLayer

signal puzzle_solved
signal puzzle_canceled

@onready var slot_local = $PuzzleArea/SlotValue
@onready var slot_data = $PuzzleArea/SlotValue2

@onready var canoar_drag = $InventoryArea/DraggableCanoar
@onready var tres_retas_drag = $InventoryArea/DraggableTresRetas
@onready var date_time_drag = $InventoryArea/DraggableDateTime
@onready var date_incident_drag = $InventoryArea/DraggableIncidentDate

func _ready() -> void:
	
	if GameManager.canoar_unlocked:
		canoar_drag.show()
	else:
		canoar_drag.hide()
	
	if GameManager.time_syntaxe_unlocked:
		date_time_drag.show()
	else:
		date_time_drag.hide()

func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("ui_cancel"):
		puzzle_canceled.emit()
		queue_free()
		
func _on_resolve_glitch_button_pressed() -> void:
	var is_local_correct = slot_local.current_value == "\"Canoar\""
	var is_data_correct = slot_data.current_value == "DateTime.Now()"
	
	if is_local_correct and is_data_correct:
		print("Puzzle resolvido")
		
		GameManager.solved_glitches += 1
		GameManager.poster_solved = true
		print(GameManager.solved_glitches)
		puzzle_solved.emit()
		queue_free()
	else:
		print("Puzzle não resolvido")
		GameManager.shake_screen()


func _on_close_button_pressed() -> void:
	puzzle_canceled.emit()
	queue_free()
