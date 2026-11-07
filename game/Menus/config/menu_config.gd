extends Control

@onready var button_screen_size_l: Button = %ButtonScreenSizeL
@onready var label_screen_size: Label = %LabelScreenSize
@onready var button_screen_size_r: Button = %ButtonScreenSizeR
@onready var h_slider_musica: HSlider = %HSliderMusica

func _ready() -> void:
	_update_values()

func _update_values() -> void:
	var screen_size : Vector2i = GerenciadorSave.get_config(GerenciadorSave.ConfigType.SIZE_TELA)
	label_screen_size.text = "%d x %d" % [screen_size.x, screen_size.y]
	var vol_musica : float = GerenciadorSave.get_config(GerenciadorSave.ConfigType.VOL_MUSICA)
	h_slider_musica.set_value_no_signal(vol_musica)
