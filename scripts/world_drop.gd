extends Control

const WORLD_ITEM = preload("uid://bba1rn5pflg44")


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true
	

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var node = WORLD_ITEM.instantiate()
	
	node.set_meta("item_data", data.item)
	node.get_node("Sprite2D").texture = data.item.icon  # Error
	
	get_tree().current_scene.add_child(node)
	data.item = null
	node.global_position = Vector2(2, 1)
	print("Droped out")
	
