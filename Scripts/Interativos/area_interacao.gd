extends Area2D
class_name AreaDeInteracao


@export var nome_acao: String = "interagir"
@export_enum("Item", "Dialogo") var tipo_de_interacao: int = 0


var interagir: Callable = func():
	pass


func _on_body_entered(_body: Node2D) -> void:
	GerirInteracao.registra_area(self)

func _on_body_exited(_body: Node2D) -> void:
	GerirInteracao.desregistra_area(self)
