## Gerenciador Mood
## [br]
## Valor: [br] 
## 1 - min [br]
## 2 - mid [br]
## 3 - max [br]

## class_name GerenciadorMood
extends Node

signal updated_mood(mood: Mood, valor: int)

enum Mood {
	FELICIDADE,
	COMIDA,
	LIMPEZA,
	MENTAL,
	FOBIA,
}

## Qnt perde por minuto
@export var taxa_perda_valor_moods : Dictionary[GerenciadorMood.Mood, float] = {
	GerenciadorMood.Mood.FELICIDADE: 	40.0,
	GerenciadorMood.Mood.MENTAL:  		25.0,
	GerenciadorMood.Mood.FOBIA: 		10.0,
	GerenciadorMood.Mood.COMIDA:  		50.0,
	GerenciadorMood.Mood.LIMPEZA:  		30.0,
}

## valor atual dos moods
var _valor_moods : Dictionary[GerenciadorMood.Mood, float] = {
	GerenciadorMood.Mood.FELICIDADE: 	100.0,
	GerenciadorMood.Mood.MENTAL:  		100.0,
	GerenciadorMood.Mood.FOBIA: 		100.0,
	GerenciadorMood.Mood.COMIDA:  		100.0,
	GerenciadorMood.Mood.LIMPEZA:  		100.0,
}

func _abaixar_moods() -> void:
	pass
