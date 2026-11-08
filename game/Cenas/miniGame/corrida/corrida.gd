extends Control
class_name Corrida

const pulo_duracao := 0.9
const pulo_duracao_ar := 0.2

const velocidade_acel := 1.15 

@onready var character: Node2D = %Character
@onready var coco_spawner: Node2D = %CocoSpawner

@onready var end_screen: Control = $EndScreen
@onready var label_pontos: Label = %LabelPontos

@onready var label_pontuacao: Label = %LabelPontuacao

const CHARACTER_COCO = preload("uid://1b16bu51hxuy")

var velocidade_atual := 1.0

var pontos : int = 0

var no_chao := true
var jogo_rolando := true

func _ready() -> void:
	_timer_velocidade()
	_timer_obstaculo()
	end_screen.hide()

# Spawns
# -----------------------------------------------------------------------------
func _timer_velocidade() -> void:
	var timer := get_tree().create_timer(3.0)
	timer.timeout.connect(_timer_velocidade)
	
	velocidade_atual *= velocidade_acel

func _timer_obstaculo() -> void:
	if not jogo_rolando: return
	
	var delay := randf_range(1.2, 4.0)
	var timer := get_tree().create_timer(delay)
	timer.timeout.connect(_timer_obstaculo)
	
	var coco := CHARACTER_COCO.instantiate()
	coco_spawner.add_child(coco)
	coco.position = Vector2.ZERO
	coco.set_velocidade_corrida(velocidade_atual)

# Pulo
# -----------------------------------------------------------------------------
func _on_button_click_pressed() -> void:
	if not jogo_rolando: return
	pular()

func pular() -> void:
	if not no_chao: return
	no_chao = false
	
	var tweenIn := create_tween()
	tweenIn.set_ease(Tween.EASE_OUT)
	tweenIn.set_trans(Tween.TRANS_CUBIC)
	tweenIn.tween_property(
		character,
		"position:y",
		-200,
		pulo_duracao / 2
	)
	await tweenIn.finished
	
	await get_tree().create_timer(pulo_duracao_ar).timeout
	
	var tweenOut := create_tween()
	tweenOut.set_ease(Tween.EASE_IN)
	tweenIn.set_trans(Tween.TRANS_EXPO)
	tweenOut.tween_property(
		character,
		"position:y",
		0,
		pulo_duracao / 2
	)
	
	get_tree().create_timer(pulo_duracao/3).timeout.connect(func(): no_chao = true)

# Areas
# -----------------------------------------------------------------------------
func _on_area_2d_body_entered(_body: Node2D) -> void:
	_fim_corrida()

func _on_area_2_pontos_body_entered(_body: Node2D) -> void:
	if not jogo_rolando: return
	
	pontos += 1
	
	label_pontuacao.text = str(pontos)
	label_pontos.text = str(pontos)

# Fim Corrida
# -----------------------------------------------------------------------------
func _fim_corrida() -> void:
	jogo_rolando = false
	
	var tween := create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(
		end_screen,
		"modulate:a",
		1.0,
		pulo_duracao
	).from(0.0)
	
	end_screen.show()
	
