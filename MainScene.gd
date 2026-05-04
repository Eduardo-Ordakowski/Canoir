extends Node


func _ready() -> void:
	start_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_game ():
	$DetetiveFix.start($SpanwPoint.position) 
