extends Node

var cursor_walk
var cursor_interact
var cursor_blocked

enum CursorType { WALK, INTERACT, BLOCKED }

func _ready() -> void:
	set_cursor(CursorType.WALK)
	
func set_cursor(type: CursorType) -> void:
	match type:
		CursorType.WALK:
			Input.set_custom_mouse_cursor(cursor_walk, Input.CURSOR_ARROW, Vector2(0, 0))
		CursorType.INTERACT:
			Input.set_custom_mouse_cursor(cursor_interact, Input.CURSOR_ARROW, Vector2(0, 0))
		CursorType.BLOCKED:
			Input.set_custom_mouse_cursor(cursor_blocked, Input.CURSOR_ARROW, Vector2(0, 0))
