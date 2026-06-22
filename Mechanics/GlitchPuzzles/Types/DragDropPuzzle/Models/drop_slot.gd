extends PanelContainer

var current_value: String = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	
	if typeof(data) == TYPE_DICTIONARY and data.has("value"):
		return true
	
	return false

func _drop_data(at_position: Vector2, data: Variant) -> void:	
	
	current_value = data["value"]
	$Label.text = current_value
	
	modulate = Color("8f1b1bff")
