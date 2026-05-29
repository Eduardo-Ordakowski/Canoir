extends Area2D

@export var target_scene: String = "res://Stages/AlternativeOffice/AlternativeOffice.tscn"
func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name == "DetetiveFix":
		print("Player entrou na área. Trocando mapa...")
		
		set_deferred("monitoring", false)
		
		GameManager.transition_to_screen(target_scene)
