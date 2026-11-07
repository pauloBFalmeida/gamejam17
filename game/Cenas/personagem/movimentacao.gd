extends Node
class_name MovimentacaoPersonagem

@export var velocidade := 0.8
## distancia chegar objetivo (squared)
@export var dist_chegar := 0.02

@export var pulinho_altura := 0.08
@export var pulinho_freq := 0.3


const min_x_direcao := 0.6
const rotacao_duracao := 1.2 ## em seg

@export var img_pivot: Node3D
@export var sprite_3d: Sprite3D
@export var navigation_agent_3d: NavigationAgent3D
@export var personagem: CharacterBody3D

var esta_andando : bool = false
var acc_time := 0.0

var tween_rot : Tween
var tween_pulinhos : Tween

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		comecar_pulinhos()
	
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
	comecar_pulinhos()

func _parar_andar() -> void:
	esta_andando = false
	parar_pulinhos()

func get_direcao() -> Vector3:
	var dest := navigation_agent_3d.get_next_path_position()
	var local_dest = dest - personagem.global_position
	
	if local_dest.length_squared() < dist_chegar:
		_parar_andar()
	
	var direction = local_dest.normalized()
	return direction

func rotacionar(horario: bool = false) -> void:
	if is_instance_valid(tween_rot) and tween_rot.is_running(): return
	
	if horario and sprite_3d.flip_h: return
	elif (not horario) and (not sprite_3d.flip_h): return
	
	tween_rot = create_tween()
	tween_rot.set_ease(Tween.EASE_IN_OUT)
	tween_rot.set_trans(Tween.TRANS_SINE)
	tween_rot.tween_property(
		sprite_3d,
		"rotation:y",
		-PI if horario else PI,
		rotacao_duracao
	).from(0.0)
	await tween_rot.finished
	sprite_3d.flip_h = horario
	sprite_3d.rotation.y = 0.0

func comecar_pulinhos() -> void:
	if tween_pulinhos:
		tween_pulinhos.stop()
	
	tween_pulinhos = create_tween()
	tween_pulinhos.set_ease(Tween.EASE_IN_OUT)
	tween_pulinhos.set_trans(Tween.TRANS_QUAD)
	tween_pulinhos.tween_property(
		img_pivot,
		"position:y",
		pulinho_altura,
		pulinho_freq
	).from(0.0)
	#await tween_pulinhos.finished
	tween_pulinhos.tween_property(
		img_pivot,
		"position:y",
		0.0,
		pulinho_freq
	).from(pulinho_altura)
	tween_pulinhos.set_loops()

func parar_pulinhos() -> void:
	if tween_pulinhos:
		tween_pulinhos.stop()
	
	var tween := create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(
		img_pivot,
		"position:y",
		0.0,
		pulinho_freq
	).from_current()
	
