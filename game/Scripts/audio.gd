extends AudioStreamPlayer

const volume_range := 5.0

var mutado := false

func _ready() -> void:
	## 0.0 - 1.0
	var volume : float = GerenciadorSave.get_config(GerenciadorSave.ConfigType.VOL_MUSICA)
	# se for mt baixo, muta
	if volume < 0.05: mutado = true
	# transforma a media de 0.5 -> 1.0
	volume *= 2 
	#
	volume_db = volume * volume_range
	
	if mutado:
		volume_db = -80
