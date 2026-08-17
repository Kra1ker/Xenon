extends CharacterBody2D

@export var speed: float = 300.0
@export var bounce_height: float = 12.0
@export var bounce_speed: float = 18.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var target_position: Vector2 = Vector2.ZERO
var is_moving_to_target: bool = false

var bounce_time: float = 0.0
var original_sprite_y: float = 0.0

func _ready() -> void:
	if sprite:
		original_sprite_y = sprite.position.y
		sprite.play("idle")
	target_position = global_position
	
#func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		#target_position = get_global_mouse_position()
		#is_moving_to_target = true
		
func _physics_process(delta: float) -> void:
	var input_x: float = 0.0
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		input_x -= 1.0
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		input_x += 1.0

	if input_x != 0.0:
		is_moving_to_target = false
		velocity.x = input_x * speed
		velocity.y = 0.0
		sprite.play("walk")
		sprite.flip_h = input_x < 0
	elif is_moving_to_target:
		var direction = (target_position - global_position).normalized()
		var distance = global_position.distance_to(target_position)
		
		if distance < 5.0:
			is_moving_to_target = false
			velocity = Vector2.ZERO
			sprite.play("idle")
		else:
			velocity = direction * speed
			sprite.play("walk")
			if direction.x != 0:
				sprite.flip_h = direction.x < 0
	else:
		velocity = Vector2.ZERO
		sprite.play("idle")

	move_and_slide()
	
	if velocity != Vector2.ZERO:
		bounce_time += delta * bounce_speed
		var bounce_offset = abs(sin(bounce_time)) * bounce_height
		sprite.position.y = original_sprite_y - bounce_offset
	else:
		bounce_time = 0.0
		sprite.position.y = move_toward(sprite.position.y, original_sprite_y, delta * 100.0)
