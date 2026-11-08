extends Window
class_name WindowOpcoes

@onready var label_moedas: Label = %LabelMoedas

func close() -> void:
	queue_free()

func _ready() -> void:
	close_requested.connect(close)
	var jogo_size : Vector2i = GerenciadorSave.get_config(GerenciadorSave.ConfigType.SIZE_TELA)
	size.y = jogo_size.y
	position = get_parent().get_window().position
	position.x -= jogo_size.x
	
	_update_dinheiro()

func _update_dinheiro() -> void:
	label_moedas.text = str(GerenciadorGrana.moedas)

const custo_comida := 10

func _on_button_comida_1_pressed() -> void:
	if GerenciadorGrana.pode_comprar(custo_comida):
		GerenciadorGrana.dar_item(GerenciadorGrana.Item.ComidaHotdog)
	_update_dinheiro()

func _on_button_comida_2_pressed() -> void:
	if GerenciadorGrana.pode_comprar(custo_comida):
		GerenciadorGrana.dar_item(GerenciadorGrana.Item.ComidaMaca)
	_update_dinheiro()

func _on_button_comida_3_pressed() -> void:
	if GerenciadorGrana.pode_comprar(custo_comida):
		GerenciadorGrana.dar_item(GerenciadorGrana.Item.ComidaPeixe)
	_update_dinheiro()


const custo_mimo := 15
func _on_button_mimo_pressed() -> void:
	if GerenciadorGrana.pode_comprar(custo_mimo):
		GerenciadorGrana.dar_item(GerenciadorGrana.Item.Presente)
	_update_dinheiro()


func _on_button_mg_pressed() -> void:
	GerenciadorGrana.game_screen.trocar_tela(GameScreen.Tela.MINIGAME_CORRIDA)
	close()


var pode_limpar := true
func _on_button_limopar_pressed() -> void:
	if not pode_limpar: return
	GerenciadorGrana.dar_item(GerenciadorGrana.Item.Sabao)
	pode_limpar = false
	get_tree().create_timer(10.0).timeout.connect(func(): pode_limpar = true)

var pode_conversar := true
func _on_button_conversar_pressed() -> void:
	if not pode_conversar: return
	GerenciadorGrana.dar_item(GerenciadorGrana.Item.Mao)
	pode_conversar = false
	get_tree().create_timer(10.0).timeout.connect(func(): pode_conversar = true)
