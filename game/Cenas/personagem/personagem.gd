extends CharacterBody3D

@export var velocidade := 0.8

const min_x_direcao := 0.6
const rotacao_duracao := 1.2 ## em seg

@onready var sprite_3d: Sprite3D = $Sprite3D
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

var deve_andar : bool = false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		var random_pos := Vector3.ZERO
		random_pos.x = randf_range(-1.2, 1.2)
		random_pos.z = randf_range(-1.2, 1.2)
		navigation_agent_3d.target_position = random_pos
		
		deve_andar = false 
		
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
	deve_andar = true

func get_direcao() -> Vector3:
	var dest := navigation_agent_3d.get_next_path_position()
	var local_dest = dest - global_position
	var direction = local_dest.normalized()
	return direction

func _physics_process(delta: float) -> void:
	if not deve_andar: return
	
	velocity = get_direcao() * velocidade
	move_and_slide()

var tween : Tween

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
