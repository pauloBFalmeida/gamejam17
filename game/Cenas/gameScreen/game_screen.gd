class_name GameScreen
extends Control

@export var duracao_transicao := 1.2

@onready var game: Game = $SubViewportContainer/SubViewport/Game

@onready var menus: Control = $Menus

@onready var transition: ColorRect = $Transition

const MENU_CONFIG = preload("uid://cmt0o3s58ai60")

var menu_config : MenuConfig

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_A:
			mostar_menu_config()
		elif event.keycode == KEY_S:
			fechar_menu_config()
		
		elif event.keycode == KEY_G:
			ir_sala()
		elif event.keycode == KEY_H:
			ir_banheiro()

# Trocar Comodo
# -----------------------------------------------------------------------------
func ir_sala() -> void:
	var _tween := _transicao()
	if _tween: _tween.finished.connect(func(): game.comodo.trocar_comodo(Comodo.Local.SALA))

func ir_banheiro() -> void:
	var _tween := _transicao()
	if _tween: _tween.finished.connect(func(): game.comodo.trocar_comodo(Comodo.Local.BANHEIRO))

# Menu Config
# -----------------------------------------------------------------------------

func mostar_menu_config() -> void:
	menus.hide()
	var _tween := _transicao()
	if _tween: _tween.finished.connect(
		func(): 
			menu_config = MENU_CONFIG.instantiate()
			menus.add_child(menu_config)
			menus.show()
			menu_config.abrir()
	)

func fechar_menu_config() -> void:
	var _tween := _transicao()
	if _tween: _tween.finished.connect(
		func(): 
			menus.hide()
			menu_config.queue_free()
	)

# Mini Game
# -----------------------------------------------------------------------------


# Transicao
# -----------------------------------------------------------------------------

func _transicao() -> Tween:
	if transition.visible: return null
	
	transition.show()
	
	var tweenIn := create_tween()
	tweenIn.set_ease(Tween.EASE_IN)
	tweenIn.set_trans(Tween.TRANS_CUBIC)
	tweenIn.tween_property(
		transition,
		"modulate:a",
		1.0,
		duracao_transicao / 2
	).from(0.0)
	
	tweenIn.finished.connect(_transicao_out)
	
	return tweenIn

func _transicao_out() -> void:
	var tweenOut := create_tween()
	tweenOut.set_ease(Tween.EASE_OUT)
	tweenOut.set_trans(Tween.TRANS_CUBIC)
	tweenOut.tween_property(
		transition,
		"modulate:a",
		0.0,
		duracao_transicao / 2
	).from(1.0)
	
	tweenOut.finished.connect(func(): transition.hide())
