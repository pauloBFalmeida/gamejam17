extends Window
class_name WindowOpcoes

func close() -> void:
	queue_free()

func _ready() -> void:
	close_requested.connect(close)
	var jogo_size : Vector2i = GerenciadorSave.get_config(GerenciadorSave.ConfigType.SIZE_TELA)
	size.y = jogo_size.y
	position = get_parent().get_window().position
	position.x -= jogo_size.x
