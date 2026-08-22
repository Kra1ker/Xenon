extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


var data_bak
func _notification(what: int) -> void:
	"""
	NOTE: in case items don't render properly after changing places between
	each other and occasionally disappear in the inventory (usually same 
	items) reset this commit: "Refactor: inventory notification func"
	<62f836e22f5950b7735324d53719ae428426034e>
	"""
	if what == Node.NOTIFICATION_DRAG_BEGIN:
		on_drag_begin()
	if what == Node.NOTIFICATION_DRAG_END:
		on_drag_begin()


func on_drag_begin() -> void:
	data_bak = get_viewport().gui_get_drag_data()
	

func on_drag_end() -> void:
	if not is_drag_successful() and data_bak:
		data_bak.icon.show()
		data_bak = null
