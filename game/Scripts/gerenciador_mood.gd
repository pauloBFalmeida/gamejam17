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

# TODO: TIRAR
## Qnt perde por minuto
#@export var taxa_perda_valor_moods : Dictionary[Mood, float] = {
	#GerenciadorMood.Mood.FELICIDADE: 	40.0,
	#GerenciadorMood.Mood.MENTAL:  		25.0,
	#GerenciadorMood.Mood.FOBIA: 		10.0,
	#GerenciadorMood.Mood.COMIDA:  		30.0,
	#GerenciadorMood.Mood.LIMPEZA:  	25.0,
#}
@export var taxa_perda_valor_moods : Dictionary[Mood, float] = {
	GerenciadorMood.Mood.FELICIDADE: 	80.0,
	GerenciadorMood.Mood.MENTAL:  		50.0,
	GerenciadorMood.Mood.FOBIA: 		20.0,
	GerenciadorMood.Mood.COMIDA:  		60.0,
	GerenciadorMood.Mood.LIMPEZA:  		50.0,
}

# -----------------------------------------------------------------------------

## valor atual dos moods
var _valor_moods : Dictionary[Mood, float] = {
	GerenciadorMood.Mood.FELICIDADE: 	100.0,
	GerenciadorMood.Mood.MENTAL:  		100.0,
	GerenciadorMood.Mood.FOBIA: 		100.0,
	GerenciadorMood.Mood.COMIDA:  		100.0,
	GerenciadorMood.Mood.LIMPEZA:  		100.0,
}

var pausado : bool = false

var tem_fobia_atencao := false
var tem_fobia_sujeira := false

var contador_atencao := 1
var contador_sujeira := 1

## Descrece mais rapido cada vez nessa porcent
## [br] multiplicador_fobia ** contador_fobia
const multiplicador_fobia := 1.2

func _physics_process(delta: float) -> void:
	if pausado : return
	
	_abaixar_moods(delta)


#var contador := 0
func _abaixar_moods(seg:float) -> void:
	#contador += 1
	#if contador > 10: contador = 0
	
	for _mood in Mood.values():
		var taxa_perda := taxa_perda_valor_moods[_mood] * seg / 60
		# se for o mental e tiver fobia de atencao
		if _mood == Mood.MENTAL and tem_fobia_atencao:
			taxa_perda = taxa_perda * (multiplicador_fobia ** contador_atencao)
		elif _mood == Mood.LIMPEZA and tem_fobia_sujeira:
			taxa_perda = taxa_perda * (multiplicador_fobia ** contador_sujeira)
			
		_valor_moods[_mood] -= taxa_perda
		_valor_moods[_mood] = max(0.0, _valor_moods[_mood])
		
		#if contador == 0:
			#updated_mood.emit(_mood, _valor_moods[_mood])

func dar_atencao() -> void:
	contador_atencao += 1
func dar_limpeza() -> void:
	contador_sujeira += 1

func get_status_mood(_mood: Mood) -> int:
	var valor := _valor_moods[_mood]
	if valor > 60.0:
		return Status.MAX
	elif valor > 30.0:
		return Status.MID
	return Status.MIN

func set_pausar(pausar: bool) -> void:
	pausado = pausar
