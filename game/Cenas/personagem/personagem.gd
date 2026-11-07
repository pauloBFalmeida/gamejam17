extends CharacterBody3D

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		var random_pos := Vector3.ZERO
		random_pos.x = randf_range(-1.2, 1.2)
		random_pos.z = randf_range(-1.2, 1.2)
		navigation_agent_3d.target_position = random_pos

func _physics_process(delta: float) -> void:
	var dest := navigation_agent_3d.get_next_path_position()
	var local_dest = dest - global_position
	var direction = local_dest.normalized()
	
	velocity = direction * 3
	move_and_slide()
