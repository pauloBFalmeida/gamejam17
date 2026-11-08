extends Sprite3D

## em segundos
@export var tempo_trocar_img := 8.0

func _ready() -> void:
	imagem()


func imagem() -> void:
	get_tree().create_timer(tempo_trocar_img).timeout.connect(imagem)
	var img_n := randi_range(0,5)
	frame = img_n
