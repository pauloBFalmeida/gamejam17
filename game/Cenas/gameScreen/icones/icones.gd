class_name IconesUI
extends Control

@export var imgs_res_por_mood : Dictionary[GerenciadorMood.Mood, ImgsMoodRes] = {
	GerenciadorMood.Mood.FELICIDADE: preload("uid://dp75t3gbjdftd"),
	GerenciadorMood.Mood.MENTAL: preload("uid://cup72km5uarck"),
	GerenciadorMood.Mood.FOBIA: preload("uid://vjemhq4rmgeh"),
	GerenciadorMood.Mood.COMIDA: preload("uid://dsb1kdbpptef8"),
	GerenciadorMood.Mood.LIMPEZA: preload("uid://b15yv6v2m83ps"),
}

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
		var img_res : ImgsMoodRes = imgs_res_por_mood[_mood]
		var tex : Texture = img_res.get_img(valor)
		_icon.texture = tex
