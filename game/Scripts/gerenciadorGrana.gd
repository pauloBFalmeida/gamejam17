extends Node

# TODO: 0
var moedas : int = 100

var personagem : Personagem
var game_screen: GameScreen

enum Item {
	ComidaPeixe,
	ComidaHotdog,
	ComidaMaca,
	Presente,
	Mao,
	Sabao,
}

func pode_comprar(valor: int) -> bool:
	print("COMPRAR ", valor)
	if  moedas >= valor:
		moedas -= valor
		return true
	return false
	
const HOTDOG = preload("uid://bv344y5r8qk5d")
const MACA = preload("uid://dedoxfdocobkg")
const PEIXE = preload("uid://dga6femiiv3e6")
const GIFT = preload("uid://lvv2ucvm3c4u")
const LUVINHA = preload("uid://1nw31rgaiijo")
const SABAO = preload("uid://v1hsgr823gnv")

func dar_item(item: Item) -> void:
	personagem.dar_item(item)

func get_texture(item: Item) -> Texture:
	match item:
		Item.ComidaPeixe:
			return PEIXE
		Item.ComidaMaca:
			return MACA
		Item.ComidaHotdog:
			return HOTDOG
		Item.Presente:
			return GIFT
		Item.Mao:
			return LUVINHA
		Item.Sabao:
			return SABAO
	return null
			
