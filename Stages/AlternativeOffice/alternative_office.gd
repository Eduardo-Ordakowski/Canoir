extends Node2D
@onready var detective = $DetetiveFix
@onready var anim_outro = $Outro/ColorRect/AnimationPlayer
@onready var canva_outro = $Outro
@onready var ambient_song = $AmbientSong

var can_interact_table_dialog = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_dialog_1_body_entered(body: Node2D) -> void:
	if body.name == "DetetiveFix":
		GameManager.show_dialog("Tem algo de errado aqui...\nTudo está fora do lugar...", 2.0)
		$Dialog1.queue_free()


func _on_dialog_2_body_entered(body: Node2D) -> void:
	if body.name == "DetetiveFix":
		GameManager.show_dialog("Preciso dar um jeito de sair daqui...", 2.0)
		$Dialog2.queue_free()

func _on_dialog_3_body_entered(body: Node2D) -> void:
	if body.name == "DetetiveFix" and GameManager.poster_solved:
		GameManager.show_dialog("Se eu conseguisse voltar para aquele dia...\n"
		+"Se eu pudesse entender o que houve com ela...", 5.0)
		$Dialog3.queue_free()


func _on_table_dialog_body_entered(body: Node2D) -> void:
	if body.name == "DetetiveFix":
		can_interact_table_dialog = true
func _on_table_dialog_body_exited(body: Node2D) -> void:
	if body.name == "DetetiveFix":
		can_interact_table_dialog = false 
func _unhandled_input(event: InputEvent) -> void:
	if can_interact_table_dialog and event.is_action_pressed("interact"):
		GameManager.show_dialog("Sem override dessa vez...")
		 
func _on_end_alpha_body_entered(body: Node2D) -> void:
	if body.name == "DetetiveFix":
		detective.in_cutscene = true
		
		anim_outro.animation_finished.connect(_on_outro_finished)
		anim_outro.play("Outro")
		
		var tween = create_tween()
		tween.tween_property(ambient_song, "volume_db", -80, 2)
		tween.tween_callback(ambient_song.stop)
		
func _on_outro_finished(anim_name: String) -> void:
	if anim_name == "Outro":
	
		await get_tree().create_timer(0.5).timeout
		get_tree().quit()


	
