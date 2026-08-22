extends Control

# Scene (lvl) to make items spawn in
const WORLD_ITEM = preload("uid://bba1rn5pflg44")
@onready var inventory_grid: GridContainer = get_parent().get_node(
	"Inventory/Inventory/Panel/MarginContainer/InventoryGridContainer"
	)


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true
	

# Get items out (spawning instance in 2d world)
func _drop_data(at_position: Vector2, data: Variant) -> void:
	var node = WORLD_ITEM.instantiate()  # Scene (lvl) to make items spawn in
	
	# SPAWNING items in the world (lvl)
	node.set_meta("item_data", data.item)
	node.get_node("Sprite2D").texture = data.item.icon
	node.get_node("CollisionShape2D").shape = data.item.collision_shape
	
	get_tree().current_scene.add_child(node)
	data.item = null
	node.global_position = Vector2(2, 1)
	print("Droped out")
	

func _notification(what: int) -> void:
	if what == Node.NOTIFICATION_DRAG_BEGIN:
		mouse_filter = Control.MOUSE_FILTER_PASS
	if what == Node.NOTIFICATION_DRAG_END:
		mouse_filter = Control.MOUSE_FILTER_IGNORE
		

# Get items back
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			print("Pressed")
			var results: Array = get_cursor_hits()
			for result in results:
				var collider = result["collider"]
				
				if collider is CharacterBody2D:
					put_item_in_inventory(collider)
					return
					

func get_cursor_hits() -> Array:
	"""
	Checks what's under cursor. Returns a an Array with hits.
	"""
	var cam := get_viewport().get_camera_2d()
	var space := cam.get_world_2d().direct_space_state
	
	var param := PhysicsPointQueryParameters2D.new()
	param.position = cam.get_global_mouse_position()
	param.collide_with_areas = true
	param.collide_with_bodies = true
	
	return space.intersect_point(param)
	

func is_collider():
	pass
	

func put_item_in_inventory(world_item: CharacterBody2D) -> void:
	"""
	Excepts: CharacterBody2D as parameter. Seeks free slot and puts the
	target in it.
	"""
	# Gets first empty slot
	for slot in inventory_grid.get_children():
		if slot.item:
			continue
			
		slot.item = world_item.get_meta("item_data")
		slot.update_ui()
		world_item.queue_free()
		return
