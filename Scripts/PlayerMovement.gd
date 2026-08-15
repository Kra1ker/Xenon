extends CharacterBody2D

@export var speed: float = 300.0
@export var bounce_height: float = 12.0
@export var bounce_speed: float = 18.0

@onready var sprite: Sprite2D = $Sprite2D

var target_position: Vector2 = Vector2.ZERO
var is_moving: bool = false

var bounce_time: float = 0.0
var original_sprite_y: float = 0.0

func _ready() -> void:
	if sprite:
		original_sprite_y = sprite.position.y
	target_position = global_position
	
func _unhandled_input(event: InputEvent) -> void:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			target_position = get_global_mouse_position()
			is_moving = true
		
func _physics_process(delta: float) -> void:
	if is_moving:
		var direction = (target_position - global_position).normalized()
		var distance = global_position.distance_to(target_position)
		
		if distance < 5.0:
			is_moving = false
			velocity = Vector2.ZERO
		else:
			velocity = direction * speed
			if direction.x != 0:
				sprite.flip_h = direction.x < 0

	move_and_slide()
	
	if is_moving:
		bounce_time += delta * bounce_speed
		var bounce_offset = abs(sin(bounce_time)) * bounce_height
		sprite.position.y = original_sprite_y - bounce_offset
	else:
		bounce_time = 0.0
		sprite.position.y = move_toward(sprite.position.y, original_sprite_y, delta * 100.0)
