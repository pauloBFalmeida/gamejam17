class_name GameScreen
extends Control

@onready var game: Node = $SubViewportContainer/SubViewport/Game

@onready var menus: Control = $Menus
@onready var menu_config: Control = $Menus/MenuConfig


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_A:
			menus.hide()
			menu_config.hide()
		elif event.keycode == KEY_S:
			menus.show()
			menu_config.show()
			menu_config.abrir()
