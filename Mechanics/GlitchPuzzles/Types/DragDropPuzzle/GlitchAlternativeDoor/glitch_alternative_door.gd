extends CanvasLayer

signal puzzle_solved
signal puzzle_canceled

@onready var slot_func = $PuzzleArea/SlotValue
@onready var slot_local = $PuzzleArea/SlotValue2
@onready var slot_time = $PuzzleArea/SlotValue3

@onready var open_drag = $InventoryArea/DraggableOpen
@onready var exit_drag = $InventoryArea/DraggableExit
@onready var canoar_drag = $InventoryArea/DraggableCanoar
@onready var office_drag = $InventoryArea/DraggableOffice
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
	var is_func_correct = slot_func.current_value.to_lower() == "open"
	var is_local_correct = slot_local.current_value.to_lower() == "\"canoar\""
	var is_time_correct = slot_time.current_value.to_lower() == "incidentdate()"
	
	if is_func_correct and is_local_correct and is_time_correct:
		print("Puzzle resolvido")
		
		GameManager.poster_solved = true
		
		puzzle_solved.emit()
		queue_free()
		
	elif slot_func.current_value.to_lower() == "exit":
		print("Fechando o jogo...")
		
		GameManager.game_was_reset = true
		await get_tree().create_timer(0.5).timeout
		get_tree().quit()
	
	elif  slot_local.current_value.to_lower() == "\"office\"":
		print("Resetando o jogo...")
		
		GameManager.game_was_reset = true
		GameManager.reset_game()
		queue_free()
		get_tree().change_scene_to_file("res://MainScene.tscn")
	
	else:
		print("Puzzle não resolvido")
		GameManager.shake_screen()


func _on_close_button_pressed() -> void:
	puzzle_canceled.emit()
	queue_free()
