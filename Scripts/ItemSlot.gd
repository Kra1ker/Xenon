extends Panel

@onready var icon: TextureRect = $Icon


func _get_drag_data(_at_position: Vector2) -> Variant:
	if icon.texture == null:
		return
	
	var preview = duplicate()
	set_drag_preview(preview)
	return icon
