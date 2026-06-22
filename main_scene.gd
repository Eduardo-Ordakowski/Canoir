extends Node

@onready var animation_player = $Office/Intro/AnimationPlayer
@onready var intro = $Office/Intro
@onready var detective = $DetetiveFix

func _ready() -> void:
	detective.in_cutscene = true;
	animation_player.animation_finished.connect(_on_intro_finished)
	
	animation_player.play("Title")
	
	start_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_intro_finished (anim_name: String):
	if anim_name == "Title":
		detective.in_cutscene = false
		$Office/OfficeSong.play()
		intro.queue_free() 

func start_game ():
	$DetetiveFix.start($SpanwPoint.position) 
