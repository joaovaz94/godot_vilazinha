extends Node2D

@onready var texto_iniciar : Label = $CanvasLayer/label_comecar
@onready var vilazinha = preload("res://Cenas/vila.tscn")

var texto_visivel : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			comecar_jogo()

func _on_tempo_piscar_timeout() -> void:
	if texto_visivel:
		texto_iniciar.visible = false
		texto_visivel = false
	else:
		texto_iniciar.visible = true
		texto_visivel = true
		

func comecar_jogo():
	#get_tree().change_scene_to_file("res://Cenas/vila.tscn")
	get_tree().change_scene_to_packed(vilazinha)
