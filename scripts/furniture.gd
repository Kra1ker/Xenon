@tool
extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision: CollisionPolygon2D = $CollisionPolygon2D

const SCALE_READY := 0.9
const SCALE_SILHOUETTE := 6.0

@export var furniture: FurnitureData:
	set(value):
		furniture = value
		if is_node_ready():
			update_furniture()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_furniture()


func set_visual(ready: bool) -> void:
	if ready:
		sprite_2d.texture = furniture.texture_ready
		sprite_2d.scale = Vector2.ONE * SCALE_READY
	else:
		sprite_2d.texture = furniture.silhouette_texture
		sprite_2d.scale = Vector2.ONE * SCALE_SILHOUETTE
	

func update_furniture() -> void:
	if not furniture:
		return
	
	set_visual(true)
	#collision.polygon = furniture.collision_shape.segments
