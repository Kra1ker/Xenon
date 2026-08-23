@tool
extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var furniture: FurnitureData:
	set(value):
		furniture = value
		if is_node_ready():
			update_visual()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_visual()


func update_visual() -> void:
	if not furniture:
		return
	
	sprite_2d.texture = furniture.texture
