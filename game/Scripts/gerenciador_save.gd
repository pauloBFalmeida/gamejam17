extends Node

const FILENAME_CONFIG := "user://config.cfg"
const SECTION_CONFIG := "Config"

enum ConfigType {
	SIZE_TELA,
	VOL_MUSICA,
}

const configName := {
	ConfigType.SIZE_TELA: "tamanho_tela",
	ConfigType.VOL_MUSICA: "volume_musica",
}

# Possibilidades
# -----------------------------------------------------------------------------

const configDefault := {
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




# Pegar do arquivo
# -----------------------------------------------------------------------------
var configuracoes = {}

func _enter_tree() -> void:
	carregar()

func get_config(config_type: ConfigType) -> Variant:
	var config_nome : String = configName[config_type]
	return configuracoes[config_nome]

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

func set_default_values() -> void:
	for config_type in ConfigType.values():
		var config_nome : String = configName[config_type]
		configuracoes[config_nome] = configDefault[config_type]

# Ajustes
# -----------------------------------------------------------------------------

func set_tamanho_tela(tamanho: Vector2i) -> void:
	DisplayServer.window_set_size(tamanho)
