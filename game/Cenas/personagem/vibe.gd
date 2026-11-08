extends Node
class_name Vibe

@export var sprite_3d_emote: Sprite3D

enum Emote {
	BRAVO_INDIGNADO,
	CANSADO,
	DOENTE,
	CHORANDO,
	DUVIDANDO,
	FELIZ,
	FOFO,
	LINGUINHA,
	MORTO,
	TIMIDO,
	TRISTE,
	UM_OLHO,
	WTF,
}


const AMARELO_BRAVO_INDIGNADO_ = preload("uid://bk7y6dsbsw7uw")
const AMARELO_CANSADO = preload("uid://ce4kkh8p5iwxr")
const AZUL_DOENTE = preload("uid://bo10hn75fwgfa")
const EMOTI_CHORANDO = preload("uid://dis83tvwkrspc")
const EMOTI_DUVIDANDO = preload("uid://vnb084s3i6ak")
const EMOTI_FELIZ = preload("uid://b5tjfwuwe1svn")
const EMOTI_FOFO = preload("uid://bu7u6xrg87r1a")
const EMOTI_LINGUINHA = preload("uid://c3qnxvfe5qcta")
const EMOTI_MORTO = preload("uid://c86qklnr8h8je")
const EMOTI_TIMIDO = preload("uid://bo8nrgb4rxwt4")
const EMOTI_TRISTE = preload("uid://c4djden5gli7n")
const EMOTI_UM_OLHO_SO = preload("uid://c41osrhhhcwhr")
const EMOTI_WTF = preload("uid://clo5ccybwaqh1")

var emote_to_img : Dictionary[Emote, Texture] = {
	Emote.BRAVO_INDIGNADO: 	AMARELO_BRAVO_INDIGNADO_,
	Emote.CANSADO: 			AMARELO_CANSADO,
	Emote.DOENTE: 			AZUL_DOENTE,
	Emote.CHORANDO: 		EMOTI_CHORANDO,
	Emote.DUVIDANDO: 		EMOTI_DUVIDANDO,
	Emote.FELIZ: 			EMOTI_FELIZ,
	Emote.FOFO: 			EMOTI_FOFO,
	Emote.LINGUINHA: 		EMOTI_LINGUINHA,
	Emote.MORTO: 			EMOTI_MORTO,
	Emote.TIMIDO: 			EMOTI_TIMIDO,
	Emote.TRISTE: 			EMOTI_TRISTE,
	Emote.UM_OLHO: 			EMOTI_UM_OLHO_SO,
	Emote.WTF: 				EMOTI_WTF,
}

const rotation_range := PI/12
const rotation_duracao := 1.2

func _ready() -> void:
	tirar_vibe()
	mudar_vibe(Emote.LINGUINHA)
	
	var tween := create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(sprite_3d_emote, "rotation:z", rotation_range, rotation_duracao).from(-rotation_range)
	tween.tween_property(sprite_3d_emote, "rotation:z", -rotation_range, rotation_duracao).from(rotation_range)
	tween.set_loops()

func mudar_vibe(_emote: Emote) -> void:
	sprite_3d_emote.show()
	sprite_3d_emote.texture = emote_to_img[_emote]

func tirar_vibe() -> void:
	sprite_3d_emote.hide()
