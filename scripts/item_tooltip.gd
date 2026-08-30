extends PanelContainer
class_name ItemTooltip

@onready var item_name_label: Label = $MarginContainer/VBoxContainer/ItemName
@onready var description_label: Label = $MarginContainer/VBoxContainer/Description
@onready var combine_label: Label = $MarginContainer/VBoxContainer/CombineLabel


func show_item(item: ItemData) -> void:
	item_name_label.text = item.item_name
	description_label.text = item.description
	
	show()


func hide_tooltip() -> void:
	hide()
