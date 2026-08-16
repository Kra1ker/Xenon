extends Control

@onready var click_button: AudioStreamPlayer = $Audio/ClickButton
@onready var vboxbuttons = $VBoxButtons
@onready var label = $Label
@onready var button_credits = $ButtonCredits
@onready var credits_panel = $CreditsMembers
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_start_pressed() -> void:
	print("Start Pressed")
	get_tree().change_scene_to_file("res://scenes/level.tscn")
	click_button.play()


func _on_button_settings_pressed() -> void:
	print("Settings Pressed")
	click_button.play()


func _on_button_exit_pressed() -> void:
	print("Exit Pressed")
	get_tree().quit()
	click_button.play()


func _on_button_credits_pressed() -> void:
	click_button.play()
	credits_panel.show()
	
	vboxbuttons.hide()
	vboxbuttons.process_mode = Node.PROCESS_MODE_DISABLED
	label.hide()
	label.process_mode = Node.PROCESS_MODE_DISABLED
	button_credits.hide()
	button_credits.process_mode = Node.PROCESS_MODE_DISABLED


func _on_button_close_credits_pressed() -> void:
	click_button.play()
	credits_panel.hide()
	
	vboxbuttons.show()
	vboxbuttons.process_mode = Node.PROCESS_MODE_INHERIT
	label.show()
	label.process_mode = Node.PROCESS_MODE_INHERIT
	button_credits.show()
	button_credits.process_mode = Node.PROCESS_MODE_INHERIT
