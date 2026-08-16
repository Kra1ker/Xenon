extends Node2D

var item_scene = preload("res://scenes/floating_banana.tscn")

@export var items_count: int = 5
@export var cauldron_radius: float = 200.0

func _ready () -> void:
	spawn_items()
	
func spawn_items() -> void:
	var center = get_viewport_rect().size / 2.0
	
	for i in range(items_count):
		var item = item_scene.instantiate()
		add_child(item)
		
		var start_angle = (TAU / items_count) * i
		item.orbit_radius = cauldron_radius + randf_range(-20.0, 20.0)
		item.orbit_speed = randf_range(1.0, 2.5)
		item.item_name = "Banana" + str(i + 1)
		
		item.setup(center, start_angle)
		item.item_caught.connect(_on_item_caught)

func _on_item_caught(item_name: String) -> void:
	print(item_name)
