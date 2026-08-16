extends Control

const WORLD_ITEM = preload("uid://bba1rn5pflg44")


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true
	

# Get items out (spawning instance in 2d world)
func _drop_data(at_position: Vector2, data: Variant) -> void:
	var node = WORLD_ITEM.instantiate()
	
	node.set_meta("item_data", data.item)
	node.get_node("Sprite2D").texture = data.item.icon  # Error
	
	get_tree().current_scene.add_child(node)
	data.item = null
	node.global_position = Vector2(2, 1)
	print("Droped out")


# Get items back
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			print("Pressed")
			
			var cam := get_viewport().get_camera_2d()
			var space := cam.get_world_2d().direct_space_state
			
			var param = PhysicsRayQueryParameters2D.new()
			param.from = cam.project_ray_origin(event.position)
			param.to = param.from + cam.project_ray_normal(event.position) * 100
			
			var ray := space.intersect_ray(param)
			if ray and ray["collider"] is RigidBody2D:
				var world_item = ray["collider"]
				for slot in %InventoryGridContainer.get_children():
					if slot.item: continue
					
					# Gets first empty slot
					slot.item = ray["collider"].get_meta("item_data")
					slot.update_ui()
					world_item.queue_free()
					break
					
