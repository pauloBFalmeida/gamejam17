class_name MiniGameCoco
extends CharacterBody2D

const SPEED = 300.0
const DIRECAO := Vector2.LEFT

var velocidade_modifier: float = 1.0

func set_velocidade_corrida(_velocidade: float) -> void:
	velocidade_modifier = _velocidade

func _ready() -> void:
	get_tree().create_timer(5.0).timeout.connect(queue_free)

func _physics_process(delta: float) -> void:
	velocity = DIRECAO * SPEED * velocidade_modifier
	move_and_slide()
