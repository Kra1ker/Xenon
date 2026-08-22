extends Node2D

var item_scene = preload("res://scenes/floating_banana.tscn")
var item_scene2 = preload("res://scenes/world_item.tscn")
const BANANA = preload("uid://bvsfyvn4yh0jy")
const PENCIL = preload("uid://dt56lhnaqt2p2")


@export var item: ItemData
@export var items_count: int = 5
@export var cauldron_radius: float = 200.0
@onready var camera: Camera2D = $Camera2D


func _ready () -> void:
	camera.enabled = true
	camera.make_current()
	spawn_items()


func spawn_items() -> void:
	# Spawn items using resources. Details: check world_drop.gd 
	# (drop datafunction)
	var r = 800
	spawn_an_item(BANANA, 
	Vector2(randi_range(r, r), randi_range(r, r))
	)
	spawn_an_item(PENCIL,
	Vector2(randi_range(r, r), randi_range(r, r))
	)
	
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

func spawn_an_item(item_data: ItemData, position: Vector2) -> void:
	var item = item_scene2.instantiate()
	add_child(item)

	item.global_position = position
