extends StaticBody2D

@export var puzzle_scene: PackedScene

var detective_ref = null

func _ready() -> void:
	$AnimatedSprite2D.play("DoorAnimation")

func _process(delta: float) -> void:
	pass

func activate_glitch(detective):
	detective_ref = detective
	
	if puzzle_scene:
		var puzzle = puzzle_scene.instantiate()
		get_tree().root.add_child(puzzle)
		
		puzzle.puzzle_solved.connect(_on_puzzle_completed)
		puzzle.puzzle_canceled.connect(_on_puzzle_canceled)

func _on_puzzle_completed():
	print ("Glitch conclído...")
	
	if detective_ref:
		detective_ref.opened_puzzle = false
	
	$CollisionShape2D.set_deferred("disabled", true)
	queue_free()
	hide()
	
func _on_puzzle_canceled():
	if detective_ref:
		detective_ref.opened_puzzle = false
