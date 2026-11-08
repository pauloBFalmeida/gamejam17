class_name GameScreen
extends Control

enum Tela {
	GAME,
	MENU_CONFIG,
	MINIGAME_CORRIDA,
}
enum Sala {
	SALA_ESTAR,
	BANHEIRO,
}

@export var duracao_transicao := 1.2

@onready var game: Game = $SubViewportContainer/SubViewport/Game

@onready var menus: Control = $Menus

@onready var transition: ColorRect = $Transition

const MENU_CONFIG = preload("uid://cmt0o3s58ai60")
const CORRIDA = preload("uid://bvh3yenoa4ufj")
const WINDOW_OPCOES = preload("uid://wdl2378mtpea")

var tela_atual := Tela.GAME
var sala_atual := Sala.SALA_ESTAR

var menu_config : MenuConfig
var minigame_corrida : Corrida

# TODO: TIRAR
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_Q:
			trocar_tela(Tela.GAME)
		#elif event.keycode == KEY_A:
			#trocar_tela(Tela.MENU_CONFIG)
		elif event.keycode == KEY_S:
			trocar_tela(Tela.MINIGAME_CORRIDA)

func _ready() -> void:
	menus.hide()

# Trocar Comodo
# -----------------------------------------------------------------------------
func ir_sala() -> void:
	var _tween := _transicao()
	if _tween: _tween.finished.connect(func(): game.comodo.trocar_comodo(Comodo.Local.SALA))

func ir_banheiro() -> void:
	var _tween := _transicao()
	if _tween: _tween.finished.connect(func(): game.comodo.trocar_comodo(Comodo.Local.BANHEIRO))


# Troca de telas
# -----------------------------------------------------------------------------
func trocar_tela(_tela: Tela) -> void:
	if tela_atual == _tela: return
	tela_atual = _tela
	
	var _tween := _transicao()
	if _tween: _tween.finished.connect(_trocar_tela.bind(_tela))

func _trocar_tela(_tela: Tela) -> void:
	game.pausar()
	if is_instance_valid(minigame_corrida): 	minigame_corrida.queue_free()
	if is_instance_valid(menu_config): 			menu_config.queue_free()
	
	match _tela:
		Tela.GAME:
			menus.hide()
			game.despausar()
		Tela.MENU_CONFIG:
			menu_config = MENU_CONFIG.instantiate()
			menus.add_child(menu_config)
			menus.show()
			menu_config.abrir()
		Tela.MINIGAME_CORRIDA:
			minigame_corrida = CORRIDA.instantiate()
			menus.add_child(minigame_corrida)
			menus.show()

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


var window_op : WindowOpcoes
func _on_button_diabo_pressed() -> void:
	if is_instance_valid(window_op):
		window_op.close()
		return
	
	window_op = WINDOW_OPCOES.instantiate() as WindowOpcoes
	add_child(window_op)


func _on_button_config_pressed() -> void:
	if tela_atual == Tela.MENU_CONFIG:
		trocar_tela(Tela.GAME)
	else:
		trocar_tela(Tela.MENU_CONFIG)

func _on_button_comodo_pressed() -> void:
	if tela_atual != Tela.GAME: return
	
	if sala_atual == Sala.SALA_ESTAR:
		sala_atual = Sala.BANHEIRO
		ir_banheiro()
	elif sala_atual == Sala.BANHEIRO:
		sala_atual = Sala.SALA_ESTAR
		ir_sala()
