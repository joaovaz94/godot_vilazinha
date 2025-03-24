class_name ItemVida extends ItemInventario

@export var cura_de_vida: int = 1

func usar(jogador: Jogador) -> void:
	jogador.recuperar_vida(cura_de_vida)
