extends HBoxContainer

@onready var CoracaoGUIClass = preload("res://Cenas/UI/coracao_gui.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func defineMaxCoracoes(max: int):
	for i in range(max):
		var coracao = CoracaoGUIClass.instantiate()
		add_child(coracao)

func atualizaCoracoes(vidaAtual: int):
	var coracoes = get_children()
	
	for i in range(vidaAtual):
		coracoes[i].atualiza(true)
	
	for i in range(vidaAtual, coracoes.size()):
		coracoes[i].atualiza(false)
