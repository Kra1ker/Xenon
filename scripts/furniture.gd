@tool
extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision: CollisionPolygon2D = $CollisionPolygon2D

const SCALE_CRAFTED := 0.2
const SCALE_SILHOUETTE := 1.5

@export var furniture: FurnitureData:
	set(value):
		furniture = value
		if is_node_ready():
			update_furniture()

# Accesible via editor turns silhouette/ready modes
@export var is_crafted := true:
	set(value):
		is_crafted = value
		if is_node_ready():
			set_visual(value)
			

func _ready() -> void:
	update_furniture()
	

func set_visual(ready: bool) -> void:
	if ready:
		sprite_2d.texture = furniture.texture_ready
		sprite_2d.scale = Vector2.ONE * SCALE_CRAFTED
		collision.polygon = furniture.collision_ready
	else:
		sprite_2d.texture = furniture.texture_silhouette
		sprite_2d.scale = Vector2.ONE * SCALE_SILHOUETTE
		collision.polygon = furniture.collision_silhouette
		

func update_furniture() -> void:
	if not furniture:
		return

	set_visual(is_crafted)
	
