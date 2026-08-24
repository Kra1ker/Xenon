extends Node2D

# TODO make item array in the scene inspector, in case there is going to
# be much bigger amount of items
const BANANA = preload("uid://bvsfyvn4yh0jy")
const PENCIL = preload("uid://dt56lhnaqt2p2")
const BOOKS = preload("uid://brjb6vcmk4y5s")
const WORLD_ITEM = preload("uid://bba1rn5pflg44")

var item_scene = preload("res://scenes/floating_banana.tscn")
var item_scene2 = preload("res://scenes/world_item.tscn")

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
	var r_max = 800
	var r_min = 0
	spawn_an_item(BANANA, 
	Vector2(randi_range(r_min, r_max), randi_range(r_min, r_max))
	)
	spawn_an_item(PENCIL,
	Vector2(randi_range(r_min, r_max), randi_range(r_min, r_max))
	)
	spawn_an_item(BOOKS,
	Vector2(randi_range(r_min, r_max), randi_range(r_min, r_max))
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
	"""
	Tikimfox's varriant of spawning items. Feel free to copy it.
	Items spawned this way will also work with the inventory system.
	"""
	
	var node = WORLD_ITEM.instantiate()

	node.set_meta("item_data", item_data)
	node.get_node("Sprite2D").texture = item_data.icon
	node.get_node("CollisionPolygon2D").polygon = item_data.collision_shape.points

	get_tree().current_scene.add_child(node)
	node.global_position = position
