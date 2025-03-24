extends CharacterBody2D
class_name Jogador

signal vidaMudou

@onready var anim_tree = $AnimationTree
#estado da arvore de animação
@onready var anim_estado = anim_tree.get("parameters/playback")
@onready var efeitos = $efeitos
@onready var tempo_ferido = $tempoFerido

@export var inventario: Inventario

@export var vida_maxima: int = 4
var vida_atual: int = vida_maxima

var potencia_knockback: int = 1200

var input_movement = Vector2.ZERO
var speed = 75
var pode_mover: bool

enum estado_jogador {MOVENDO, ROLANDO, MORRENDO}
var estado_atual = estado_jogador.MOVENDO

func _ready() -> void:
	pode_mover = true
	inventario.usou_item.connect(usar_item)
	efeitos.play("RESET")

func _physics_process(_delta: float) -> void:
	match estado_atual:
		estado_jogador.MOVENDO:
			mover()
		estado_jogador.ROLANDO:
			rolar()
		estado_jogador.MORRENDO:
			morrer()
	manejaColisao()
	

	
func mover():
	
	input_movement = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if input_movement != Vector2.ZERO && pode_mover:
		
		anim_tree.set("parameters/Parado/blend_position", input_movement)
		anim_tree.set("parameters/Andando/blend_position", input_movement)
		anim_tree.set("parameters/Rolando/blend_position", input_movement)
		anim_estado.travel("Andando")
		
		velocity = input_movement * speed
	
	if input_movement == Vector2.ZERO || !pode_mover:
		anim_estado.travel("Parado")
		velocity = Vector2.ZERO
		
	if Input.is_action_just_pressed("rolar"):
		estado_atual = estado_jogador.ROLANDO
	
	if vida_atual <= 0:
		estado_atual = estado_jogador.MORRENDO
	
	move_and_slide()

func rolar():
	anim_estado.travel("Rolando")
	velocity = (input_movement * speed)
	move_and_slide()

func morrer():
	anim_estado.travel("morrendo")
	await get_tree().create_timer(1).timeout
	vida_atual = vida_maxima
	get_tree().reload_current_scene()

func recuperar_vida(qtd_cura: int):
	vida_atual += qtd_cura
	vida_atual = min(vida_maxima, vida_atual)
	vidaMudou.emit(vida_atual)

func usar_item(item: ItemInventario) -> void:
	item.usar(self)

func congela_movimento():
	pode_mover = false

func descongela_movimento():
	pode_mover = true

func manejaColisao():
	for i in get_slide_collision_count():
		var colisao = get_slide_collision(i)
		var colisor = colisao.get_collider()
		#print_debug(colisor.name)

func _on_hurtbox_area_entered(area: Area2D) -> void:
	#print_debug("entrou :" + area.name)
	if area.has_method("coletar"):
		area.coletar(inventario)
	if area.is_in_group("Inimigos"):
		vida_atual -= 1
		#if vida_atual < 0:
			#vida_atual = vida_maxima
			
		vidaMudou.emit(vida_atual)
		knockback(area.get_parent().velocity)
		efeitos.play("piscando_ferido")
		tempo_ferido.start()
		await tempo_ferido.timeout
		efeitos.play("RESET")
		

func on_reseta_estado():
	estado_atual = estado_jogador.MOVENDO

func knockback(velocityInimigo: Vector2):
	var dirKnockback = (velocityInimigo -velocity).normalized() * potencia_knockback
	velocity = dirKnockback
	move_and_slide()
