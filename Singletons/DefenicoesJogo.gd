extends Node

@onready var camera = get_tree().get_first_node_in_group("camera")
@onready var jogador = get_tree().get_first_node_in_group("jogador")

signal mudou_cena

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mudou_cena.connect(_on_mudou_cena)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass # Replace with function body.

func _on_mudou_cena():
	camera = get_tree().get_first_node_in_group("camera")
	jogador = get_tree().get_first_node_in_group("jogador")
