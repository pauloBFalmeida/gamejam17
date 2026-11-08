class_name Personagem
extends CharacterBody3D

const TOMBSTONE = preload("uid://yvmntp4pm3hy")

@onready var sprite_3d: Sprite3D = %Sprite3D
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var movimentacao: MovimentacaoPersonagem = $Movimentacao

@onready var sprite_3d_emote: Sprite3D = %Sprite3DEmote

var vivo := true
var posicao_inicial : Vector3

func _ready() -> void:
	get_tree().create_timer(1.0).timeout.connect(func(): posicao_inicial = position)


func andar_para(global_pos: Vector3) -> void:
	movimentacao.andar_para(global_pos)

func _physics_process(delta: float) -> void:
	if not movimentacao.esta_andando: return
	
	velocity = movimentacao.get_direcao() * movimentacao.velocidade
	
	move_and_slide()

func morrer() -> void:
	vivo = false
	position = posicao_inicial
	sprite_3d.texture = TOMBSTONE
	sprite_3d.position.y += -0.2
	process_mode = Node.PROCESS_MODE_DISABLED
