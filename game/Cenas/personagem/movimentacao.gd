extends Node
class_name MovimentacaoPersonagem

@export var velocidade := 0.8
## distancia chegar objetivo (squared)
@export var dist_chegar := 0.02

@export var pulinho_altura := 0.12
@export var pulinho_freq := 8.0


const min_x_direcao := 0.6
const rotacao_duracao := 1.2 ## em seg

@export var img_pivot: Node3D
@export var sprite_3d: Sprite3D
@export var navigation_agent_3d: NavigationAgent3D
@export var personagem: CharacterBody3D

var esta_andando : bool = false
var acc_time := 0.0

var tween : Tween

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		var random_pos := Vector3.ZERO
		random_pos.x = randf_range(-1.2, 1.2)
		random_pos.z = randf_range(-1.2, 1.2)
		navigation_agent_3d.target_position = random_pos
		
		esta_andando = false 
		acc_time = 0.0
		
		var direcao := get_direcao()
		if direcao.x < -min_x_direcao:
			rotacionar(true)
			get_tree().create_timer(rotacao_duracao/2).timeout.connect(_comecar_andar)
		elif direcao.x > min_x_direcao:
			rotacionar(false)
			get_tree().create_timer(rotacao_duracao/2).timeout.connect(_comecar_andar)
		else:
			_comecar_andar()

func _comecar_andar() -> void:
	esta_andando = true

func get_direcao() -> Vector3:
	var dest := navigation_agent_3d.get_next_path_position()
	var local_dest = dest - personagem.global_position
	
	if local_dest.length_squared() < dist_chegar:
		esta_andando = false
	
	var direction = local_dest.normalized()
	return direction

func rotacionar(horario: bool = false) -> void:
	if is_instance_valid(tween) and tween.is_running(): return
	
	if horario and sprite_3d.flip_h: return
	elif (not horario) and (not sprite_3d.flip_h): return
	
	tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(
		sprite_3d,
		"rotation:y",
		-PI if horario else PI,
		rotacao_duracao
	).from(0.0)
	await tween.finished
	sprite_3d.flip_h = horario
	sprite_3d.rotation.y = 0.0

func pulinhos(delta: float) -> void:
	if not esta_andando: return
	
	acc_time += delta
	
	img_pivot.position.y = abs(sin(acc_time*pulinho_freq) * pulinho_altura)
