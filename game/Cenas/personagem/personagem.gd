class_name Personagem
extends CharacterBody3D

const TOMBSTONE = preload("uid://yvmntp4pm3hy")

@onready var sprite_3d: Sprite3D = %Sprite3D
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var movimentacao: MovimentacaoPersonagem = $Movimentacao

@onready var sprite_3d_emote: Sprite3D = %Sprite3DEmote
@onready var sprite_3d_item: Sprite3D = %Sprite3DItem
@onready var sprite_3d_item_posicao:= sprite_3d_item.position

var vivo := true
var posicao_inicial : Vector3

func _ready() -> void:
	sprite_3d_item.hide()
	get_tree().create_timer(1.0).timeout.connect(func(): posicao_inicial = position)
	GerenciadorGrana.personagem = self

func andar_para(global_pos: Vector3) -> void:
	movimentacao.andar_para(global_pos)

func _physics_process(delta: float) -> void:
	if not movimentacao.esta_andando: return
	
	velocity = movimentacao.get_direcao() * movimentacao.velocidade
	
	move_and_slide()

func dar_item(item: GerenciadorGrana.Item) -> void:
	print("ITEM")
	sprite_3d_item.texture = GerenciadorGrana.get_texture(item)
	sprite_3d_item.show()
	var tween := create_tween()
	tween.tween_property(sprite_3d_item, "position:y",
	sprite_3d_item_posicao.y+0.2, 1.6).from(sprite_3d_item_posicao.y)
	tween.parallel()
	tween.tween_property(sprite_3d_item, "modulate:a", 0.0, 1.8).from(1.0)
	
	tween.finished.connect(
		func():
			sprite_3d_item.hide()
	)

func morrer() -> void:
	vivo = false
	position = posicao_inicial
	sprite_3d.texture = TOMBSTONE
	sprite_3d.position.y += -0.2
	process_mode = Node.PROCESS_MODE_DISABLED
