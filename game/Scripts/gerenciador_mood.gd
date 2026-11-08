## Gerenciador Mood
## [br]
## Valor: (Status) [br] 
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

enum Status {
	MIN = 1,
	MID = 2,
	MAX = 3,
}

## Qnt perde por minuto
@export var taxa_perda_valor_moods : Dictionary[Mood, float] = {
	GerenciadorMood.Mood.FELICIDADE: 	40.0,
	GerenciadorMood.Mood.MENTAL:  		25.0,
	GerenciadorMood.Mood.FOBIA: 		10.0,
	GerenciadorMood.Mood.COMIDA:  		50.0,
	GerenciadorMood.Mood.LIMPEZA:  		30.0,
}

## valor atual dos moods
var _valor_moods : Dictionary[Mood, float] = {
	GerenciadorMood.Mood.FELICIDADE: 	100.0,
	GerenciadorMood.Mood.MENTAL:  		100.0,
	GerenciadorMood.Mood.FOBIA: 		100.0,
	GerenciadorMood.Mood.COMIDA:  		100.0,
	GerenciadorMood.Mood.LIMPEZA:  		100.0,
}

var pausado : bool = false

func _abaixar_moods() -> void:
	pass

func get_status_mood(_mood: Mood) -> int:
	var valor := _valor_moods[_mood]
	if valor > 60.0:
		return Status.MAX
	elif valor > 30.0:
		return Status.MID
	return Status.MIN

func set_pausar(pausar: bool) -> void:
	pausado = pausar
