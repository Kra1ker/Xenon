extends Panel

@onready var icon: TextureRect = $Icon
@export var item: ItemData :
	set(value):
		item = value
		if is_node_ready() and item:
			update_ui()


func _ready() -> void:
	update_ui()
	
	
func update_ui() -> void:
	if not item:
		icon.texture = null
		return
	
	icon.texture = item.icon
	tooltip_text = item.item_name


func _get_drag_data(_at_position: Vector2) -> Variant:
	if not item:
		return
	
	var preview = duplicate()
	var c = Control.new()
	c.add_child(preview)
	preview.position -= Vector2(75,75)
	preview.self_modulate = Color.TRANSPARENT
	c.modulate = Color(c.modulate, 0.5)
	
	set_drag_preview(c)
	icon.hide()
	return self


func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return true
	

func _drop_data(at_position: Vector2, data: Variant) -> void:
	
	# Swapping items may be useful in the future for
	# adding crafting
	var tmp = item  # swapping items
	item = data.item
	data.item = tmp  # swapping items
	icon.show()
	data.icon.show()
	update_ui()
	data.update_ui()
