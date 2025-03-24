extends Node

@onready var cena_caixa_de_texto = preload("res://Cenas/UI/caixa_de_texto.tscn")
@onready var camera = get_tree().get_first_node_in_group("camera")
@onready var jogador = get_tree().get_first_node_in_group("jogador")
#@onready var camera = DefenicoesJogo.camera
#@onready var jogador = DefenicoesJogo.jogador
#var camera
#var jogador


var frases_dialogo: Array[String] = []
var indice_fala_atual = 0

var caixa_de_texto
var posicao_caixa_de_texto: Vector2

var dialogo_esta_ativo = false
var pode_avancar_fala = false

signal terminou_dialogo()

func _ready() -> void:
	await get_tree().get_first_node_in_group("fase_atual")
	DefenicoesJogo.mudou_cena.connect(_on_mudou_cena)

func comecar_dialogo(frases: Array[String]):
	if dialogo_esta_ativo:
		return
	var centro_camera = camera.get_screen_center_position()
	#print(camera.get_camera_rect())
	#print(camera.get_camera_rect().end)
	#print(camera.get_camera_rect().position.x)
	#print(camera.get_camera_rect().position.y)
	#print(camera.get_camera_rect().size)
	#print(camera.get_camera_rect().size.x)
	#print(camera.get_camera_rect().size.y)
	#print("ponto dialogo: ")
	#print(posicao)
	#print(camera.vec_inside_camera(posicao))
	frases_dialogo = frases
	#posicao_caixa_de_texto =  posicao
	posicao_caixa_de_texto = Vector2(centro_camera.x , centro_camera.y +120 )
	_mostrar_caixa_de_texto()
	
	dialogo_esta_ativo = true
	jogador.congela_movimento()


func _mostrar_caixa_de_texto():
	caixa_de_texto = cena_caixa_de_texto.instantiate()
	caixa_de_texto.terminou_de_mostrar.connect(_on_caixa_de_texto_terminou_de_mostrar)
	get_tree().root.add_child(caixa_de_texto)
	caixa_de_texto.global_position = posicao_caixa_de_texto
	caixa_de_texto.mostrar_texto(frases_dialogo[indice_fala_atual])
	pode_avancar_fala = false

func _on_caixa_de_texto_terminou_de_mostrar():
	pode_avancar_fala = true

func _unhandled_input(event: InputEvent) -> void:
	if (
		event.is_action_pressed("pular_dialogo") &&
		dialogo_esta_ativo &&
		pode_avancar_fala
	):
		caixa_de_texto.queue_free()
		indice_fala_atual += 1
		if indice_fala_atual >= frases_dialogo.size():
			dialogo_esta_ativo = false
			indice_fala_atual = 0
			terminou_dialogo.emit()
			jogador.descongela_movimento()
			return
		
		_mostrar_caixa_de_texto()

func _on_mudou_cena():
	#camera = get_tree().get_first_node_in_group("fase_atual").get_first_node_in_group("camera")
	#jogador = get_tree().get_first_node_in_group("fase_atual").get_first_node_in_group("jogador")
	#camera = DefenicoesJogo.camera
	#jogador = DefenicoesJogo.jogador
	camera = get_tree().get_first_node_in_group("camera")
	jogador = get_tree().get_first_node_in_group("jogador")
	if camera == null:
		camera = get_tree().get_first_node_in_group("camera")
		print("errado")
