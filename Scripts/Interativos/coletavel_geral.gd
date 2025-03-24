extends Area2D

@export var itemResource: ItemInventario

func coletar(inventario: Inventario):
	inventario.inserir(itemResource)
	queue_free()
