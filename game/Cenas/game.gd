class_name Game
extends Node

@onready var sistema_click: SistemaClick3D = $SistemaClick
@onready var personagem: Personagem = $Mundo/Personagem

func _ready() -> void:
	sistema_click.clicou.connect(
		func(global_pos: Vector3):
			personagem.andar_para(global_pos)
	)
