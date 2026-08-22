extends Node2D

var item_scene = preload("res://scenes/floating_banana.tscn")

@export var item: ItemData :
	set(value):
		item = value
# Test
const ITEM_BANANA = preload("uid://bvsfyvn4yh0jy")  # Inventory branch item
const ITEM_PENCIL = preload("uid://dt56lhnaqt2p2")  # Inventory branch item


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
	# Test: custom item spawning (those have inventory functionality)
	spawn_an_item(ITEM_BANANA)
	spawn_an_item(ITEM_PENCIL)

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

func spawn_an_item(WORLD_ITEM) -> void:
	var node = WORLD_ITEM.instantiate()  # Scene (lvl) to make items spawn in
	
	# SPAWNING items in the world (lvl)
	node.get_node("Sprite2D").texture = item.icon
	node.get_node("CollisionShape2D").shape = item.collision_shape
	
	get_tree().current_scene.add_child(node)
	node.global_position = Vector2(randi_range(1000, 1000), 
	randi_range(1000, 1000))
	print("Item spawned")
