extends Node3D
class_name Comodo

enum Local {
	SALA,
	BANHEIRO
}

@onready var sala_estar: Node3D = $SalaEstar
@onready var banheiro: Node3D = $Banheiro

func _ready() -> void:
	trocar_comodo(Local.SALA)

func trocar_comodo(_local: Local) -> void:
	match _local:
		Local.SALA:
			banheiro.hide()
			sala_estar.show()
		Local.BANHEIRO:
			sala_estar.hide()
			banheiro.show()
