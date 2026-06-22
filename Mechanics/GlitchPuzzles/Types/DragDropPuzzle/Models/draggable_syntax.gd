extends PanelContainer

@export var syntax_value: String = "false"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = syntax_value

func _get_drag_data(at_position: Vector2) -> Variant: 
	var drag_preview = Label.new()
	drag_preview.text = syntax_value
	
	set_drag_preview(drag_preview)
	
	return {"value": syntax_value}
