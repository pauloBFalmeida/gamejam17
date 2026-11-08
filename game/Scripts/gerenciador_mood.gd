## Gerenciador Mood
## [br]
## Valor: [br] 
## 1 - min [br]
## 2 - mid [br]
## 3 - max [br]

extends Node



signal updated_mood(mood: Mood, valor: int)

enum Mood {
	FELICIDADE,
	COMIDA,
	LIMPEZA,
	MENTAL,
	FOBIA,
}
