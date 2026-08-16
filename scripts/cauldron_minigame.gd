extends Node2D

var item_scene = preload("res://scenes/floating_banana.tscn")

@export var normal_items: Array[ItemData]
@export var trash_items: Array[ItemData]

@export var max_total_items: int = 8
@export var current_level_normal_count: int = 3

func _ready() -> void:
	spawn_cauldron_contents()

func spawn_cauldron_contents() -> void:
	
	for child in get_children():
		if child is Area2D:
			child.queue_free()

	var center = get_viewport_rect().size / 2.0
	
	var trash_count = max_total_items - current_level_normal_count
	var total_to_spawn = current_level_normal_count + trash_count

	var spawn_list: Array[ItemData] = []
	
	for i in range(current_level_normal_count):
		spawn_list.append(normal_items.pick_random())
		
	for i in range(trash_count):
		spawn_list.append(trash_items.pick_random())
		
	spawn_list.shuffle()
	
	for i in range(spawn_list.size()):
		var item = item_scene.instantiate()
		add_child(item)
		
		var start_angle = (TAU / spawn_list.size()) * i
		item.orbit_radius = 100.0 + randf_range(-20.0, 20.0)
		item.orbit_speed = randf_range(1.0, 2.5)
		
		item.setup(center, start_angle, spawn_list[i])
		item.item_caught.connect(_on_item_caught)

func _on_item_caught(item_name: String) -> void:
	current_level_normal_count -= 1
	
	if current_level_normal_count > 0:
		spawn_cauldron_contents()
	else:
		print("Only trash!")
