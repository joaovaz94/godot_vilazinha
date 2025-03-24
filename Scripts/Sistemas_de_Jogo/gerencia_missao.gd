class_name GerenteMissao extends Node

@export_group("Configuracao Missao")
@export var nome_missao: String
@export var descricao_missao: String

enum EstadoMissao {
	disponivel,
	comecou,
	alcancou_objetivo,
	terminou
}

@export var estado_missao: EstadoMissao = EstadoMissao.disponivel
