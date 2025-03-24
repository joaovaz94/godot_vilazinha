extends CharacterBody2D

@onready var area_de_interacao: AreaDeInteracao = $area_interacao
@onready var jogador = get_tree().get_first_node_in_group("jogador")

@export var dialogo_json_caminho: String = "res://JSONs/Dialogos/exemplo_dialogo.json"

var fala1_dita: bool = false
var fala2_dita: bool = false
var dialogos: Dictionary

var falas: Array[String]
var fala_condicional: Array[String]
var fala_final: Array[String]

var condicional_fala: bool = false


func _ready() -> void:
	area_de_interacao.interagir = Callable(self, "_on_interagir")
	carregar_json()
	json_para_falas()



func _on_interagir():
	#fazer condição do jogador ter tacinha no inventário
	var condicao = verificar_condicao_fala()
	if !condicao && !fala1_dita :
		GerirDialogo.comecar_dialogo(falas)
		await GerirDialogo.terminou_dialogo
		fala1_dita = true
	elif condicao && !fala2_dita:
		GerirDialogo.comecar_dialogo(fala_condicional)
		await GerirDialogo.terminou_dialogo
		fala2_dita = true
	else:
		GerirDialogo.comecar_dialogo(fala_final)
		await GerirDialogo.terminou_dialogo

func carregar_json():
	var json_texto = FileAccess.get_file_as_string(dialogo_json_caminho)
	var json_dict = JSON.parse_string(json_texto)
	if json_dict:
		dialogos = json_dict 

func json_para_falas():
	if "texto_base" in dialogos:
		for item in dialogos["texto_base"]["texto"]:
			if item is String:
				falas.append(item)
	if "texto_condicional" in dialogos:
		for item in dialogos["texto_condicional"]["texto"]:
			if item is String:
				fala_condicional.append(item)
	if "texto_final" in dialogos:
		for item in dialogos["texto_final"]["texto"]:
			if item is String:
				fala_final.append(item)

func verificar_condicao_fala() -> bool:
	#var indice = jogador.inventario.encontra_item_por_nome("tacinha")
	
	if  "texto_condicional" in dialogos:
		var n_condicoes_satisfeitas = 0
		var n_condicoes_necessarias = dialogos["texto_condicional"]["condicao"]["inventario"].size()
		for item in dialogos["texto_condicional"]["condicao"]["inventario"]:
			# Modo de imprimir a chave do dicionario como string
			#print(item.keys()[0])
			if jogador.inventario.encontra_item_por_nome(item.keys()[0]) >= 0:
				n_condicoes_satisfeitas += 1
				#TODO
				#diferenciar numero de exigencias de cada item
				#Ou transferir para um sistema de missões
		if n_condicoes_satisfeitas >= n_condicoes_necessarias:
			return true
		else:
			return false
	else:
		return false
