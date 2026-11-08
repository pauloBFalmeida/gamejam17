class_name ImgsMoodRes
extends Resource

@export var img_min: Texture
@export var img_mid: Texture
@export var img_max: Texture

func get_img(valor: int = 3) -> Texture:
	match valor:
		1:
			return img_min
		2:
			return img_mid
		3:
			return img_max
	return null
