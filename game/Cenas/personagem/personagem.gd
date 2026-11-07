extends CharacterBody3D

@onready var sprite_3d: Sprite3D = $Sprite3D
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var movimentacao: MovimentacaoPersonagem = $Movimentacao

func _physics_process(delta: float) -> void:
	if not movimentacao.deve_andar: return
	
	velocity = movimentacao.get_direcao() * movimentacao.velocidade
	
	
	move_and_slide()
