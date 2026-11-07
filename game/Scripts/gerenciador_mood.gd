extends Node

signal updated_mood(mood: Mood, valor: int)

enum Mood {
	FELICIDADE,
	COMIDA,
	LIMPEZA,
	MENTAL,
	FOBIA,
}
