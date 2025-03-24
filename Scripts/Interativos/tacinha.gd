extends Area2D

@onready var area_interacao = $area_interacao
@export var itemResource: ItemInventario
@onready var jogador = get_tree().get_first_node_in_group("jogador")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_interacao.interagir = Callable(self, "_pegar_chave")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _pegar_chave():
	jogador.inventario.inserir(itemResource)
	queue_free()
