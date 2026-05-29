extends Node2D

var can_interact: bool = false
const clue_text = preload("res://Stages/Office/Clues/ClueText/TextClueTable.tscn")
var clue_text_screen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	$Area2D.monitoring = false
	GameManager.tutorial_door_clue.connect(activate_clue)

func activate_clue() -> void:
	if not GameManager.founded_sintax_override:
		show()
		$Area2D.monitoring = true

func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "DetetiveFix":
		can_interact = true
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "DetetiveFix":
		can_interact = false
		
		if clue_text_screen != null:
			clue_text_screen.queue_free()
			clue_text_screen = null
		
func _unhandled_input(event: InputEvent) -> void:
	if can_interact and event.is_action_pressed("interact"):
		print("Interagindo com a pista...")
		get_viewport().set_input_as_handled()
		GameManager.founded_sintax_override = true
		
		if has_node("PointLight2D"):
			$PointLight2D.hide()
		
		if clue_text_screen == null:
			var clue_text_screen = clue_text.instantiate()
			get_tree().root.add_child(clue_text_screen)
		else:
			clue_text_screen.queue_free()
			clue_text_screen = null
