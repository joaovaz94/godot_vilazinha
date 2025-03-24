extends CharacterBody2D

@export var velocidade = 30
@export var limite_distancia = 0.5
@export var posFinal: Marker2D

@onready var animacoes = $AnimationPlayer

var posicaoInicial
var posicaoFinal

func _ready():
	posicaoInicial = position
	#posicaoFinal = posicaoInicial + Vector2(0, 3*16)
	posicaoFinal = posFinal.global_position

func mudaDirecao():
	var tempFinal = posicaoFinal
	posicaoFinal = posicaoInicial
	posicaoInicial = tempFinal

func atualizaVelocidade():
	var movDirecao = posicaoFinal - position
	if movDirecao.length() < limite_distancia:
		mudaDirecao()
	velocity = movDirecao.normalized() * velocidade

func atualizaAnimacao():
	if velocity.length() == 0:
		if animacoes.is_playing():
			animacoes.stop()
	else:
		var direcao = "baixo"
		if velocity.x < 0: direcao = "esquerda"
		elif velocity.x > 0: direcao = "direita"
		elif velocity.y < 0: direcao = "cima"
		
		animacoes.play("andando_" + direcao)

func _physics_process(_delta: float) -> void:
	atualizaVelocidade()
	move_and_slide()
	atualizaAnimacao()
