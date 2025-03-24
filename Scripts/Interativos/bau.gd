extends Area2D


@onready var icone_it = $exclamacao
@onready var sprite = $Sprite2D
# variavel para carregar objeto de interação
@onready var area_interacao = $area_interacao

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icone_it.visible = false
	area_interacao.interagir = Callable(self, "_abrir_bau")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _abrir_bau():
	sprite.frame = 1
	

func _on_area_entered(area: Area2D) -> void:
	if area.name == "area_interacao":
		icone_it.visible = true


func _on_area_exited(_area: Area2D) -> void:
	icone_it.visible = false
