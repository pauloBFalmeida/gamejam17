class_name GameScreen
extends Control

@export var duracao_transicao := 1.2

@onready var game: Game = $SubViewportContainer/SubViewport/Game

@onready var menus: Control = $Menus
@onready var menu_config: Control = $Menus/MenuConfig


@onready var transition: ColorRect = $Transition


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_A:
			var _tween := _transicao()
			if _tween: await _tween.finished
			menus.hide()
			menu_config.hide()
		
		elif event.keycode == KEY_S:
			var _tween := _transicao()
			if _tween: await _tween.finished
			menus.show()
			menu_config.show()
			menu_config.abrir()
		
		elif event.keycode == KEY_G:
			var _tween := _transicao()
			if _tween: _tween.finished.connect(func(): game.comodo.trocar_comodo(Comodo.Local.SALA))

		elif event.keycode == KEY_H:
			var _tween := _transicao()
			if _tween: _tween.finished.connect(func(): game.comodo.trocar_comodo(Comodo.Local.BANHEIRO))


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
