extends Control

signal aberto
signal fechado

var esta_aberto: bool = false

@onready var seletor = $seletor_missao
@onready var item_missao: Array = $NinePatchRect/VBoxContainer/ColorRect/VBox_missoes.get_children()

var selecao_atual: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func abrir():
	visible = true
	esta_aberto = true
	aberto.emit()

func fechar():
	visible = false
	esta_aberto = false
	fechado.emit()

func move_seletor(dir: String) -> void:
	match dir:
		"cima":
			selecao_atual = (selecao_atual - 1 + item_missao.size()) % item_missao.size()
		"baixo":
			selecao_atual = (selecao_atual + 1) % item_missao.size()
			
	seletor.global_position = item_missao[selecao_atual].global_position

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down") && esta_aberto:
		move_seletor("baixo")

	if event.is_action_pressed("ui_up") && esta_aberto:
		move_seletor("cima")
