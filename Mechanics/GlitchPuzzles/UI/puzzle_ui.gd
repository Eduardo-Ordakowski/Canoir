extends CanvasLayer
@onready var workspace = $Workspace

signal puzzle_solved
signal puzzle_canceled
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("ui_cancel"):
		puzzle_canceled.emit()
		queue_free()
		
func _on_workspace_connection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	workspace.connect_node(from_node, from_port, to_node, to_port)

func _on_workspace_disconnection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	workspace.disconnect_node(from_node, from_port, to_node, to_port)

func _on_finish_button_pressed() -> void:
	var conexoes = workspace.get_connection_list()
	
	var core1_conectado = false
	var core2_conectado = false
	var core3_conectado = false
	
	for ligacao in conexoes:
		
		if ligacao["from_node"] == "AndGate" and ligacao["to_node"] == "TruthCore1":
			core1_conectado = true
			
		if ligacao["from_node"] == "TruthCore2" and ligacao["to_node"] == "AndGate":
			core2_conectado = true
			
		if ligacao["from_node"] == "TruthCore3" and ligacao["to_node"] == "AndGate":
			core3_conectado = true
	
	if core1_conectado and core2_conectado and core3_conectado:
		print("Puzzle concluído corretamente")
		puzzle_solved.emit()
		queue_free()
		
	else:
		print("Puzzle não concluído")
		print(core1_conectado, core2_conectado, core3_conectado)


func _on_button_pressed() -> void:
	puzzle_canceled.emit()
	queue_free()
