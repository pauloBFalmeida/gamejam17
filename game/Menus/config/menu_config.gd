extends Control

@onready var button_screen_size_l: Button = %ButtonScreenSizeL
@onready var label_screen_size: Label = %LabelScreenSize
@onready var button_screen_size_r: Button = %ButtonScreenSizeR
@onready var h_slider_musica: HSlider = %HSliderMusica

var tamanho_tela : Vector2i

func _ready() -> void:
	_update_values()

func _update_values() -> void:
	# tamanho tela
	tamanho_tela = GerenciadorSave.get_config(GerenciadorSave.ConfigType.SIZE_TELA)
	label_screen_size.text = "%d x %d" % [tamanho_tela.x, tamanho_tela.y]
	# volume
	var vol_musica : float = GerenciadorSave.get_config(GerenciadorSave.ConfigType.VOL_MUSICA)
	h_slider_musica.set_value_no_signal(vol_musica)
	# 

# Musica
# -----------------------------------------------------------------------------
func _on_h_slider_musica_value_changed(value: float) -> void:
	pass # Replace with function body.

# Tamanho Tela
# -----------------------------------------------------------------------------
func _on_button_screen_size_l_pressed() -> void:
	var idx := _get_idx_tamanho_tela(tamanho_tela)
	idx = (idx +1) % GerenciadorSave.tamanhos_tela.size()
	tamanho_tela = GerenciadorSave.tamanhos_tela[idx]
	label_screen_size.text = "%d x %d" % [tamanho_tela.x, tamanho_tela.y]

func _on_button_screen_size_r_pressed() -> void:
	var idx := _get_idx_tamanho_tela(tamanho_tela)
	idx = (idx -1) % GerenciadorSave.tamanhos_tela.size()
	tamanho_tela = GerenciadorSave.tamanhos_tela[idx]
	label_screen_size.text = "%d x %d" % [tamanho_tela.x, tamanho_tela.y]

func _on_button_ajustar_tamanho_pressed() -> void:
	GerenciadorSave.set_tamanho_tela(tamanho_tela)

func _get_idx_tamanho_tela(tamanho: Vector2i) -> int:
	return GerenciadorSave.tamanhos_tela.find(tamanho)

	

# Default
# -----------------------------------------------------------------------------
func _on_button_default_pressed() -> void:
	GerenciadorSave.set_default_values()
	_update_values()
