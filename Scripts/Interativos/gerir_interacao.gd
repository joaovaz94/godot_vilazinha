extends Node2D

@onready var jogador = get_tree().get_first_node_in_group("jogador")
#@onready var etiqueta = $Label
@onready var balao_exclamacao = $balao_exclamacao
@onready var balao_dialogo = $balao_dialogo

const texto_base = "[E] para "

var areas_ativas = []
var pode_interagir = true 

func registra_area(area: AreaDeInteracao):
	areas_ativas.push_back(area)

func desregistra_area(area: AreaDeInteracao):
	var indice = areas_ativas.find(area)
	if indice != -1:
		areas_ativas.remove_at(indice)

func _process(_delta: float) -> void:
	if areas_ativas.size() > 0 && pode_interagir:
		areas_ativas.sort_custom(_seleciona_por_distancia_do_jogador)
		
		#etiqueta.text = texto_base + areas_ativas[0].nome_acao
		#etiqueta.global_position = areas_ativas[0].global_position
		#etiqueta.global_position.y -= 36
		#etiqueta.global_position.x -= etiqueta.size.x / 2
		#etiqueta.show()
		balao_exclamacao.global_position = areas_ativas[0].global_position
		balao_exclamacao.global_position.y -= 14
		balao_dialogo.global_position = areas_ativas[0].global_position
		balao_dialogo.global_position.y -= 14
		#balao_dialogo.global_position = areas_ativas[0].global_position
		#balao_dialogo.global_position.y -= 14
		#balao_exclamacao.visible = true
		mostra_balao(areas_ativas[0])
		
	else:
		#etiqueta.hide()
		#balao_exclamacao.visible = false
		esconde_balao()
		

func _seleciona_por_distancia_do_jogador(area1, area2):
	var area1_para_jogador = jogador.global_position.distance_to(area1.global_position)
	var area2_para_jogador = jogador.global_position.distance_to(area2.global_position)
	return area1_para_jogador < area2_para_jogador

func  _input(event):
	if event.is_action_pressed("interagir") && pode_interagir:
		if areas_ativas.size() > 0:
			pode_interagir = false
			#etiqueta.hide()
			balao_exclamacao.visible = false
			
			#await areas_ativas[0].interagir.call()
			await areas_ativas[0].interagir.call()
			pode_interagir = true

func esconde_balao():
	balao_dialogo.visible = false
	balao_exclamacao.visible = false
	
func mostra_balao(area: AreaDeInteracao):
	match area.tipo_de_interacao:
		0: #Item
			balao_exclamacao.visible = true
			balao_dialogo.visible = false
		1: #Dialogo
			balao_dialogo.visible = true
			balao_exclamacao.visible = false
