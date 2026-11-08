extends Node

const FILENAME_CONFIG := "user://config.cfg"
const SECTION_CONFIG := "Config"

enum ConfigType {
	SIZE_TELA,
	VOL_MUSICA,
}

const configName : Dictionary[ConfigType, String] = {
	ConfigType.SIZE_TELA: "tamanho_tela",
	ConfigType.VOL_MUSICA: "volume_musica",
}

# Possibilidades
# -----------------------------------------------------------------------------

const configDefault : Dictionary[ConfigType, Variant] = {
	ConfigType.SIZE_TELA: Vector2i(320,320),
	ConfigType.VOL_MUSICA: 0.5,
}

const tamanhos_tela := [
	Vector2i(960,960),
	Vector2i(800,800),
	Vector2i(640,640),
	Vector2i(320,320),
	Vector2i(160,160),
]



var configuracoes : Dictionary[String, Variant] = {}

# Pegar do arquivo
# -----------------------------------------------------------------------------

func _enter_tree() -> void:
	carregar()

func get_config(config_type: ConfigType) -> Variant:
	var config_nome : String = configName[config_type]
	if configuracoes.has(config_nome):
		return configuracoes[config_nome]
	return null

func salvar() -> void:
	var config_file = ConfigFile.new()
	for config_name in configName.values():
		var valor = configuracoes[config_name]
		config_file.set_value(SECTION_CONFIG, config_name, valor)
	
	config_file.save(FILENAME_CONFIG)

func carregar() -> void:
	var config_file = ConfigFile.new()
	
	# carrega o arquivo de files
	var err = config_file.load(FILENAME_CONFIG)
	# se tiver erro pare
	if err == ERR_FILE_NOT_FOUND:
		set_default_values()
		return
	elif err != OK: return
	# pega todos os valores
	for config_name in configName.values():
		var valor = config_file.get_value(SECTION_CONFIG, config_name)
		configuracoes[config_name] = valor
	_aplicar_configs()

## ajusta todos os valores para as configuracoes
func _aplicar_configs() -> void:
	for config_type in ConfigType.values():
		_ajustar_variavel(config_type)

func set_default_values() -> void:
	for config_type in ConfigType.values():
		var config_nome : String = configName[config_type]
		configuracoes[config_nome] = configDefault[config_type]
	_aplicar_configs()
	salvar()

func _set_config(config_type: ConfigType, valor: Variant) -> void:
	var config_nome : String = configName[config_type]
	configuracoes[config_nome] = valor

# Set os valores 
# -----------------------------------------------------------------------------
func _ajustar_variavel(config_type: ConfigType) -> void:
	var _valor : Variant = get_config(config_type)
	
	# se nao conseguiu pegar o valor, pare
	if not _valor: return
	
	match config_type:
		ConfigType.SIZE_TELA:
			var tamanho: Vector2i = _valor
			DisplayServer.window_set_size(tamanho)
		ConfigType.VOL_MUSICA:
			pass

# Ajustes
# -----------------------------------------------------------------------------

func set_tamanho_tela(tamanho: Vector2i) -> void:
	_set_config(ConfigType.SIZE_TELA, tamanho)
	DisplayServer.window_set_size(tamanho)
	salvar()

func set_volume(volume: float) -> void:
	_set_config(ConfigType.VOL_MUSICA, volume)
	salvar()
