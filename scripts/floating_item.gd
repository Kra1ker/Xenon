extends Area2D

signal item_caught(item_name: String)

@export var orbit_radius: float = 120.0
@export var orbit_speed: float = 1.5
@onready var sprite: Sprite2D = $Sprite2D

var item_data: ItemData
var angle: float = 0.0
var center_position: Vector2 = Vector2.ZERO
var wave_time: float = 0.0
var is_dragging: bool = false

func setup(center: Vector2, start_angle: float, data: ItemData) -> void:
	center_position = center
	angle = start_angle
	item_data = data
	wave_time = randf_range(0.0, 100.0)
	
	if sprite and item_data:
		sprite.texture = item_data.icon
	
func _process(delta: float) -> void:
	if is_dragging:
		global_position = get_global_mouse_position()
	else:
		angle += orbit_speed * delta
		wave_time += delta * 3.0
		var dynamic_radius = orbit_radius + sin(wave_time) * 15.0
		var offset = Vector2(cos(angle), sin(angle)) * dynamic_radius
		global_position = center_position + offset
	
func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if item_data and item_data.is_trash:
		return
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		get_viewport().set_input_as_handled()
		is_dragging = true
		z_index = 100
		
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		if is_dragging:
			is_dragging = false
			z_index = 10
			_try_drop_into_inventory()

func _try_drop_into_inventory() -> void:
	var slot = _get_hovered_slot()
	
	if slot != null and slot.has_method("_drop_data"):
		var local_mouse_pos = slot.get_local_mouse_position()
		
		if slot._can_drop_data(local_mouse_pos, self):
			var data_to_pass = { self: $Sprite2D.texture }
			slot._drop_data(local_mouse_pos, data_to_pass)
			item_caught.emit(item_data.name)
			queue_free()
		
func _get_hovered_slot():
	var mouse_pos = get_global_mouse_position()
	for slot in get_tree().get_nodes_in_group("ItemSlot"):
		if slot.get_global_rect().has_point(mouse_pos):
			return slot
	return null
