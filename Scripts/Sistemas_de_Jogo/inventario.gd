extends Resource

class_name Inventario

signal atualizado
signal usou_item

#@export var items: Array[ItemInventario]
@export var espacos: Array[EspacoInventario]

func inserir(item: ItemInventario):
	for i in range(espacos.size()):
		if !espacos[i].item:
			espacos[i].item = item
			break
		
	atualizado.emit()

func encontra_item_por_nome(nome_item: String) -> int:
	for i in range(espacos.size()):
		if !espacos[i].item: 
			return -1
		if espacos[i].item.nome == nome_item:
			return i
			
	return -1

func remove_item(espaco_item: EspacoInventario):
	var indice = espacos.find(espaco_item)
	if indice < 0: return
	
	remove_no_indice(indice)

func remove_no_indice(indice: int) -> void:
	espacos[indice] = EspacoInventario.new()
	atualizado.emit()
	

func insere_item(indice: int, espaco_inventario: EspacoInventario):
	espacos[indice] = espaco_inventario
	atualizado.emit()

func usar_item_no_indice(indice: int) -> void:
	if indice < 0 || indice >= espacos.size() || !espacos[indice].item: return
	var espaco = espacos[indice]
	usou_item.emit(espaco.item)
	
	remove_no_indice(indice)
