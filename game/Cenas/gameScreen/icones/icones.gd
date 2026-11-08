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
	_atualizar_moods()

func _atualizar_moods() -> void:
	for _mood in GerenciadorMood.Mood.values():
		if _mood == GerenciadorMood.Mood.FOBIA:
			set_fobia()
		else:
			set_mood(_mood, GerenciadorMood.get_status_mood(_mood))

func set_mood(_mood: GerenciadorMood.Mood, valor: int) -> void:
	if _mood == GerenciadorMood.Mood.FOBIA: 
		set_fobia()
		return
	
	var img_res : ImgsMoodRes = imgs_res_por_mood[_mood]
	var tex : Texture = img_res.get_img(valor)
	var icon := icon_por_mood[_mood]
	icon.texture = tex

func set_fobia() -> void:
	var _mood := GerenciadorMood.Mood.FOBIA
	var valor := GerenciadorMood.get_status_mood(_mood)
	var icon := icon_por_mood[_mood]
	if valor == 1:
		icon.show()
	else:
		icon.hide()

var contador := 1
func _physics_process(delta: float) -> void:
	if contador > 5:
		contador = 0
		_atualizar_moods()
	contador += 1

var c : float = 0.0
func _process(delta: float) -> void:
	c += delta
	if c > 10.0:
		c = 0
		
		print(' -  - ')
		var m = GerenciadorMood.Mood.FELICIDADE
		print("FELICIDADE ", int(GerenciadorMood._valor_moods[m]) , " s:", GerenciadorMood.get_status_mood(m))
		m = GerenciadorMood.Mood.MENTAL
		print("MENTAL ", int(GerenciadorMood._valor_moods[m]) , " s:", GerenciadorMood.get_status_mood(m))
		m = GerenciadorMood.Mood.FOBIA
		print("FOBIA ", int(GerenciadorMood._valor_moods[m]) , " s:", GerenciadorMood.get_status_mood(m))
		m = GerenciadorMood.Mood.COMIDA
		print("COMIDA ", int(GerenciadorMood._valor_moods[m]) , " s:", GerenciadorMood.get_status_mood(m))
		m = GerenciadorMood.Mood.LIMPEZA
		print("LIMPEZA ", int(GerenciadorMood._valor_moods[m]) , " s:", GerenciadorMood.get_status_mood(m))
		
