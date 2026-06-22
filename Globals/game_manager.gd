extends CanvasLayer

#region Tremer tela
func shake_screen() -> void:
	var camera = get_viewport().get_camera_2d()
	if camera:
		var tween = create_tween()
		tween.tween_property(camera, "offset", Vector2(8, 5), 0.05)
		tween.tween_property(camera, "offset", Vector2(-8, -5), 0.05)
		tween.tween_property(camera, "offset", Vector2(5, -8), 0.05)
		tween.tween_property(camera, "offset", Vector2(-5, 5), 0.05)

		tween.tween_property(camera, "offset", Vector2(0, 0), 0.05)
#endregion

#region Sons

func right_sound():
	$RightOrder.play()
	
func wrong_sound():
	$WrongOrder.play()
	
func completed_sound():
	$CompletedOrder.play()
	
#endregion

#region Transição da cena Office para Alterantive
@onready var transition = $Transition

func transition_to_screen(scene_path: String) -> void:
	transition.play("fade_to_black")
	await transition.animation_finished
	
	get_tree().change_scene_to_file(scene_path)
	
	transition.play("fade_to_normal")
#endregion

#region reset_game()

var game_was_reset = false

func reset_game():
	solved_glitches = 0
	founded_sintax_override = false
	
	current_shelf_sequence = 0 
	get_origin_unlocked = false
	canoar_unlocked = false
	time_syntaxe_unlocked = false
	poster_solved = false

#endregion

#region show_dialog()
const dialog_screen = preload("res://Globals/DialogLabel.tscn")
var dialog_queue: Array = []
var active_dialog: Node = null

func show_dialog(dialog_text: String, timer : float = 4.0) -> void:
	dialog_queue.append({"text": dialog_text, "time": timer})
	
	if active_dialog == null:
		_process_dialog_queue()

func _process_dialog_queue() -> void:
	
	if dialog_queue.is_empty():
		return
	
	var next_dialog = dialog_queue.pop_front()
	
	active_dialog = dialog_screen.instantiate()
	get_tree().root.add_child(active_dialog)
	
	var label_text = active_dialog.get_node_or_null("PanelContainer/Label")
	
	if label_text:
		label_text.text = next_dialog["text"]
	
		active_dialog.tree_exited.connect(_on_finished_dialog)
	
		if next_dialog["time"] > 0:
			await get_tree().create_timer(next_dialog["time"]).timeout
		
			if is_instance_valid(active_dialog):
				active_dialog.queue_free()
	else:
		print("ERRO: Label não encontrado...")
		return

func _on_finished_dialog() -> void:
	active_dialog = null
	_process_dialog_queue()
	
#endregion

#region Glitches

var solved_glitches: int = 0

#region Glitch Tutorial
signal tutorial_door_clue

var founded_sintax_override: bool = false

#endregion

#region Glitch Cuia

#region Puzzle Shelfs

var shelf_sequence: Array = [4,1,3,2]
var current_shelf_sequence: int = 0 
var get_origin_unlocked: bool = false

func check_shelf(id_shelf: int) -> void:
	if get_origin_unlocked:
		print("A sinxtaxe já foi encontrada...")
		return
	
	if id_shelf == shelf_sequence[current_shelf_sequence]:
		current_shelf_sequence += 1
		$RightOrder.play()
		print("Estante correta. Progresso:", current_shelf_sequence, "/4")
		
		if current_shelf_sequence == shelf_sequence.size():
			get_origin_unlocked = true
			$CompletedOrder.play()
			
			show_dialog("Algo aconteceu...")
			print ("Sequência resolvida corretamente. Desbloqueando sintaxe...")
	else:
		current_shelf_sequence = 0 
		$WrongOrder.play()
		shake_screen()
		print("Ordem incorreta. Sequência resetada...")
		
#endregion

#region Glitch Cuia
var canoar_unlocked: bool = false

#endregion

#region Glitch Poster
var time_syntaxe_unlocked = false
var poster_solved = false

#endregion
#endregion
#endregion

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass
