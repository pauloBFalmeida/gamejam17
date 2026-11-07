class_name IconesUI
extends Control

@onready var icon_1: TextureRect = $MarginContainer/HBoxContainer/Icon1
@onready var icon_2: TextureRect = $MarginContainer/HBoxContainer/Icon2
@onready var icon_3: TextureRect = $MarginContainer/HBoxContainer/Icon3
@onready var icon_4: TextureRect = $MarginContainer/HBoxContainer/Icon4
@onready var icon_5: TextureRect = $MarginContainer/HBoxContainer/Icon5


func _ready() -> void:
	GerenciadorMood.updated_mood.connect(set_mood)

func set_mood(_mood: GerenciadorMood.Mood, valor: int = 3) -> void:
	var _icon: TextureRect
	match _mood:
		GerenciadorMood.Mood.FELICIDADE:
			_icon = icon_1
		GerenciadorMood.Mood.MENTAL:
			_icon = icon_2
		GerenciadorMood.Mood.FOBIA:
			_icon = icon_3
		GerenciadorMood.Mood.COMIDA:
			_icon = icon_4
		GerenciadorMood.Mood.LIMPEZA:
			_icon = icon_5
	
	if _icon:
		_icon.texture = null
