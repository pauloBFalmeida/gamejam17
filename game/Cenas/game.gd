class_name Game
extends Node

@onready var sistema_click: SistemaClick3D = $SistemaClick
@onready var personagem: Personagem = $Mundo/Personagem
@onready var comodo: Comodo = $Mundo/Comodo

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

## Marca se esta pausado em um menu, ou mini games
## [br] Serve para pausar a musica tbm
var pausado := false


func _ready() -> void:
	personagem.morto.connect(_morrer)
	
	sistema_click.clicou.connect(
		func(global_pos: Vector3):
			personagem.andar_para(global_pos)
	)
	

func pausar() -> void:
	pausado = true
	audio_stream_player.stream_paused = true
	GerenciadorMood.set_pausar(true)

func despausar() -> void:
	pausado = true
	audio_stream_player.stream_paused = false
	GerenciadorMood.set_pausar(false)
	


# -----------------------

func _morrer() ->void:
	criar_arquivo()

const nome_mes : Dictionary[int, String] = {
	1: "Janeiro",
	2: "Fevereiro",
	3: "Março",
	4: "Abril",
	5: "Maio",
	6: "Junho",
	7: "Julho",
	8: "Agosto",
	9: "Setembro",
	10: "Outubro",
	11: "Novembro",
	12: "Dezembro",
}

func criar_arquivo() -> void:
	var username : String
	if OS.has_environment("USERNAME"):
		username = OS.get_environment("USERNAME")
	else:
		username = "Player"
		
	var data_hoje := Time.get_datetime_dict_from_unix_time(Time.get_unix_time_from_system())
	var dia : int = data_hoje["day"]
	var mes : String = nome_mes[data_hoje["month"]]
	var ano : int = data_hoje["year"]
	
	var path_desktop := OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP)
	var path_file := path_desktop + "/%s.txt" % ["CARTA_PARA_VOCE"]
	var file = FileAccess.open(path_file, FileAccess.WRITE)
	file.store_string("Dia %d de %s de %d.\nIsso que aconteceu foi sua culpa %s, lembre-se disso" % [dia,mes,ano,username])
