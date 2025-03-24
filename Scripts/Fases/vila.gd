extends Node2D

@onready var container_coracao = $UI_Geral/ContainerCoracao
@onready var jogador = $Jogador

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	container_coracao.defineMaxCoracoes(jogador.vida_maxima)
	container_coracao.atualizaCoracoes(jogador.vida_atual)
	jogador.vidaMudou.connect(container_coracao.atualizaCoracoes)
	DefenicoesJogo.mudou_cena.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_inventario_aberto() -> void:
	get_tree().paused = true

func _on_inventario_fechado() -> void:
	get_tree().paused = false


func _on_menu_missoes_aberto() -> void:
	get_tree().paused = true


func _on_menu_missoes_fechado() -> void:
	get_tree().paused = false


func _on_menu_jogo_aberto() -> void:
	get_tree().paused = true


func _on_menu_jogo_fechado() -> void:
	get_tree().paused = false
