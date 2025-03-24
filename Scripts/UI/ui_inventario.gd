extends Control

signal aberto
signal fechado

var esta_aberto: bool = false

@onready var inventario: Inventario = preload("res://Sistemas_de_Jogo/Inventario/Inventario_Jogador.tres")
@onready var espacos_inventario: Array = $NinePatchRect/GridContainer.get_children()
@onready var seletor: Sprite2D = $Sprite2D

var selecao_atual: int = 0

func _ready() -> void:
	inventario.atualizado.connect(update)
	update()

func update():
	for i in range(min(inventario.espacos.size(), espacos_inventario.size())):
		espacos_inventario[i].update(inventario.espacos[i])

func move_seletor(dir: String) -> void:
	match dir:
		"direita":
			selecao_atual = (selecao_atual + 1) % espacos_inventario.size()
		"esquerda":
			selecao_atual = (selecao_atual - 1 + espacos_inventario.size()) % espacos_inventario.size()
		"cima":
			selecao_atual = (selecao_atual - 5 + espacos_inventario.size()) % espacos_inventario.size()
		"baixo":
			selecao_atual = (selecao_atual + 5) % espacos_inventario.size()
			
	seletor.global_position = espacos_inventario[selecao_atual].global_position

func abrir():
	visible = true
	esta_aberto = true
	aberto.emit()

func fechar():
	visible = false
	esta_aberto = false
	fechado.emit()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("confirmar_menu") && esta_aberto:
		inventario.usar_item_no_indice(selecao_atual)
	
	if event.is_action_pressed("ui_right") && esta_aberto:
		move_seletor("direita")

	if event.is_action_pressed("ui_left") && esta_aberto:
		move_seletor("esquerda")
		
	if event.is_action_pressed("ui_down") && esta_aberto:
		move_seletor("baixo")

	if event.is_action_pressed("ui_up") && esta_aberto:
		move_seletor("cima")
