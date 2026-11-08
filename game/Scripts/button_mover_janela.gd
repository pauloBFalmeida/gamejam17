extends Button

var dragging := false
var clicou_mover := false


func _input(event: InputEvent) -> void:
	# se nao tiver clicado para mover, ignore
	if not clicou_mover: return
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if not event.pressed:
				# para de seguir se largar o mouse esq
				dragging = false
				clicou_mover = false
	elif event is InputEventMouseMotion and dragging:
		# janela segue o mouse
		get_window().position += Vector2i(event.screen_relative)

func _on_pressed() -> void:
	clicou_mover = true
	# comeca a seguir o mouse
	dragging = true
