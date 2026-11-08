class_name IconesUI
extends Control

@export var imgs_res_por_mood : Dictionary[GerenciadorMood.Mood, ImgsMoodRes] = {
	GerenciadorMood.Mood.FELICIDADE: preload("uid://dp75t3gbjdftd"),
	GerenciadorMood.Mood.MENTAL: preload("uid://cup72km5uarck"),
	GerenciadorMood.Mood.FOBIA: preload("uid://vjemhq4rmgeh"),
	GerenciadorMood.Mood.COMIDA: preload("uid://dsb1kdbpptef8"),
	GerenciadorMood.Mood.LIMPEZA: preload("uid://b15yv6v2m83ps"),
}

@onready var icon_por_mood : Dictionary[GerenciadorMood.Mood, TextureRect] = {
	GerenciadorMood.Mood.FELICIDADE: 	%IconFelicidade,
	GerenciadorMood.Mood.MENTAL: 		%IconMental,
	GerenciadorMood.Mood.FOBIA:  		%IconFobia,
	GerenciadorMood.Mood.COMIDA:  		%IconComida,
	GerenciadorMood.Mood.LIMPEZA:  		%IconLimpeza,
}

func _ready() -> void:
	GerenciadorMood.updated_mood.connect(set_mood)
	
	for _mood in GerenciadorMood.Mood.values():
		set_mood(_mood, GerenciadorMood.get_status_mood(_mood))

func set_mood(_mood: GerenciadorMood.Mood, valor: int) -> void:
	var img_res : ImgsMoodRes = imgs_res_por_mood[_mood]
	var tex : Texture = img_res.get_img(valor)
	var icon := icon_por_mood[_mood]
	icon.texture = tex
