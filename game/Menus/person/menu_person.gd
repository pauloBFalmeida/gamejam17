extends Control
class_name MenuPerson

var game_screen : GameScreen

@onready var texture_rect: TextureRect = $ConfigContainer/TextureRect
@onready var label: Label = $ConfigContainer/Label

const ABANDONO_NEUTRO = preload("uid://dgeoja7h5ioqj")
const LIMPEZA_NEUTRO = preload("uid://bpwhhid57tno6")

func abrir() -> void:
	pass


func _on_button_up_pressed() -> void:
	if texture_rect.texture == ABANDONO_NEUTRO:
		texture_rect.texture = LIMPEZA_NEUTRO
		label.text = "Possui:\nFobia de Limpeza"
	else:
		texture_rect.texture = ABANDONO_NEUTRO
		label.text = "Possui:\nFobia de Abandono"

func _on_button_down_pressed() -> void:
	if texture_rect.texture == ABANDONO_NEUTRO:
		texture_rect.texture = LIMPEZA_NEUTRO
		label.text = "Possui:\nFobia de Limpeza"
	else:
		texture_rect.texture = ABANDONO_NEUTRO
		label.text = "Possui:\nFobia de Abandono"

# escolher
func _on_button_pressed() -> void:
	GerenciadorMood.personagem_fobia = GerenciadorMood.Fobia.Abandono if texture_rect.texture == ABANDONO_NEUTRO else GerenciadorMood.Fobia.Limpeza
	game_screen.trocar_tela(GameScreen.Tela.GAME)
