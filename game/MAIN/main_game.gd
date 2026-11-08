class_name MainGame
extends Node

var inicio := true

@export var game_screen: GameScreen
@export var color_rect_balck: ColorRect

func _ready() -> void:
	get_viewport().set_embedding_subwindows(false)

	if inicio : 
		_iniciar()
		inicio = false


func _iniciar() -> void:
	game_screen.trocar_tela(GameScreen.Tela.MENU_PERSONAGEM)
	
