@tool
extends StaticBody2D

@export var furniture: FurnitureData:
	set(value):
		furniture = value
		update_visual()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_visual()


func update_visual() -> void:
	if not furniture:
		return
	
	$Sprite2D.texture = furniture.texture
