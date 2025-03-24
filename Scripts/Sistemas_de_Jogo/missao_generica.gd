class_name Missao extends GerenteMissao

func comecar_missao():
	if estado_missao == EstadoMissao.disponivel:
		estado_missao = EstadoMissao.comecou

func alcancou_objetivo():
	if estado_missao == EstadoMissao.comecou:
		estado_missao = EstadoMissao.alcancou_objetivo
