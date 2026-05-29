extends Node2D

@export var id_shelf: int = 1

var can_interact: bool = false

func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "DetetiveFix":
		can_interact = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "DetetiveFix":
		can_interact = false

func _unhandled_input(event: InputEvent) -> void:
	if can_interact and event.is_action_pressed("interact"):
		get_viewport().set_input_as_handled()
		
		GameManager.check_shelf(id_shelf)
