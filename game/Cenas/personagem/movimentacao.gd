extends Node
class_name MovimentacaoPersonagem

@export var velocidade := 0.8
## distancia chegar objetivo (squared)
@export var dist_chegar := 0.02

@export var pulinho_altura := 0.08
@export var pulinho_freq := 0.3

@export var pulinho_sombra_min_scale := 0.45

@export var deve_rotacionar : bool = false

const min_x_direcao := 0.75
const rotacao_duracao := 1.2 ## em seg

@export var img_pivot: Node3D
@export var sombra_pivot: Node3D
@export var sprite_3d: Sprite3D
@export var navigation_agent_3d: NavigationAgent3D
@export var personagem: CharacterBody3D

var destino : Vector3

var esta_andando : bool = false

var tween_rot : Tween
var tween_pulinhos : Tween
var tween_pulinhos_sombra : Tween
var tween_pulinhos_squish : Tween

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		deve_rotacionar = not deve_rotacionar
	
	if event.is_action_pressed("ui_accept"):
		var random_pos := Vector3.ZERO
		random_pos.x = randf_range(-1.2, 1.2)
		random_pos.z = randf_range(-1.2, 1.2)
		navigation_agent_3d.target_position = random_pos
		
		
		andar_para(navigation_agent_3d.get_next_path_position())

func andar_para(global_pos: Vector3) -> void:
	destino = global_pos
	esta_andando = false 
	
	var direcao := get_direcao()
	
	if deve_rotacionar:
		## se fez a rotacao, entao use o timer
		var fez_rotacao: bool = false
		# calcula a direcao da rotacao
		if direcao.x < -min_x_direcao:
			fez_rotacao = rotacionar(false)
		elif direcao.x > min_x_direcao:
			fez_rotacao = rotacionar(true)
			
		# se fez a rotacao, entao use o timer, se nao, apenas ande
		if fez_rotacao:
			get_tree().create_timer(rotacao_duracao/2).timeout.connect(_comecar_andar)
		else:
			_comecar_andar()
	else:
		_comecar_andar()
		

func _comecar_andar() -> void:
	esta_andando = true
	comecar_pulinhos()

func _parar_andar() -> void:
	esta_andando = false
	parar_pulinhos()


func get_direcao() -> Vector3:
	var local_dest = destino - personagem.global_position
	
	if local_dest.length_squared() < dist_chegar:
		_parar_andar()
	
	var direction = local_dest.normalized()
	return direction

# Rotacao
# -----------------------------------------------------------------------------

## Retorna True se vai realizar o giro pro o personagem
func rotacionar(horario: bool = false) -> bool:
	if is_instance_valid(tween_rot) and tween_rot.is_running(): return false
	
	if horario and sprite_3d.flip_h: return false
	elif (not horario) and (not sprite_3d.flip_h): return false
	
	tween_rot = create_tween()
	tween_rot.set_ease(Tween.EASE_IN_OUT)
	tween_rot.set_trans(Tween.TRANS_SINE)
	tween_rot.tween_property(
		sprite_3d,
		"rotation:y",
		-PI if horario else PI,
		rotacao_duracao
	).from(0.0)
	tween_rot.finished.connect(
		func():
			sprite_3d.flip_h = horario
			sprite_3d.rotation.y = 0.0
	)
	
	return true # precisou girar o personagem

# Pulinhos 
# -----------------------------------------------------------------------------

func comecar_pulinhos() -> void:
	if tween_pulinhos:
		tween_pulinhos.stop()
		tween_pulinhos_sombra.stop()
		tween_pulinhos_squish.stop()
	
	# -- sobe
	tween_pulinhos = create_tween()
	tween_pulinhos.set_ease(Tween.EASE_IN_OUT)
	tween_pulinhos.set_trans(Tween.TRANS_QUAD)
	tween_pulinhos.tween_property(
		img_pivot,
		"position:y",
		pulinho_altura,
		pulinho_freq
	).from(0.0)
	
	tween_pulinhos_sombra = create_tween()
	tween_pulinhos_sombra.set_ease(Tween.EASE_IN_OUT)
	tween_pulinhos_sombra.set_trans(Tween.TRANS_LINEAR)
	tween_pulinhos_sombra.tween_property(
		sombra_pivot,
		"scale",
		Vector3.ONE * pulinho_sombra_min_scale,
		pulinho_freq
	)
	
	tween_pulinhos_squish = create_tween()
	tween_pulinhos_squish.set_ease(Tween.EASE_IN_OUT)
	tween_pulinhos_squish.set_trans(Tween.TRANS_CUBIC)	
	
	# -- desce
	tween_pulinhos.tween_property(
		img_pivot,
		"position:y",
		0.0,
		pulinho_freq
	).from(pulinho_altura)
	
	tween_pulinhos_sombra.tween_property(
		sombra_pivot,
		"scale",
		Vector3.ONE,
		pulinho_freq
	)
	
	tween_pulinhos_squish.tween_property(
		img_pivot, "rotation:z", PI/90, pulinho_freq
	)
	tween_pulinhos_squish.tween_property(
		img_pivot, "rotation:z", 0, pulinho_freq
	)
	tween_pulinhos_squish.tween_property(
		img_pivot, "rotation:z", -PI/90, pulinho_freq
	)
	tween_pulinhos_squish.tween_property(
		img_pivot, "rotation:z", 0, pulinho_freq
	)
	
	# -- Loops
	tween_pulinhos.set_loops()
	tween_pulinhos_sombra.set_loops()
	tween_pulinhos_squish.set_loops()

func parar_pulinhos() -> void:
	if tween_pulinhos:
		tween_pulinhos.stop()
		tween_pulinhos_sombra.stop()
		tween_pulinhos_squish.stop()
	
	var tween := create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(
		img_pivot,
		"position:y",
		0.0,
		pulinho_freq
	).from_current()
	
	sombra_pivot.scale = Vector3.ONE
	img_pivot.rotation.z = 0.0
