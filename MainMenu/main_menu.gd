extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_start_pressed() -> void:
	print("Start Pressed")
	get_tree().change_scene_to_file("res://level.tscn")


func _on_button_settings_pressed() -> void:
	print("Settings Pressed")


func _on_button_exit_pressed() -> void:
	print("Exit Pressed")
	get_tree().quit()
