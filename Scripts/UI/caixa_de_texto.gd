extends MarginContainer

@onready var etiqueta = $MarginContainer/Label
@onready var timer = $TempoMostrando

#Comprimento máximo da caixa de diálogo em pixels
const COMPRIMENTO_MAXIMO = 256

var texto = ""
var indice_letra = 0

var tempo_letra = 0.03
var tempo_espaco = 0.06
var tempo_pontuacao = 0.2

signal terminou_de_mostrar()

func mostrar_texto(texto_a_mostrar: String):
	texto = texto_a_mostrar
	etiqueta.text = texto_a_mostrar
	
	await resized
	custom_minimum_size.x = min(size.x, COMPRIMENTO_MAXIMO)
	
	if size.x > COMPRIMENTO_MAXIMO:
		etiqueta.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized #redimensao de x
		await resized #redimensao de y
		custom_minimum_size.y = size.y
		
	global_position.x -= size.x / 2
	global_position.y -= size.y + 24
	##global_position.x = 50
	#global_position.y = 200
	#print("posicao dialogo")
	#print(global_position)
	
	etiqueta.text = ""
	_mostrar_letra()

func _mostrar_letra():
	etiqueta.text += texto[indice_letra]
	
	indice_letra += 1
	if indice_letra >= texto.length():
		terminou_de_mostrar.emit()
		return
	
	match texto[indice_letra]:
		"!", ".", ",", "?":
			timer.start(tempo_pontuacao)
		" ":
			timer.start(tempo_espaco)
		_:
			timer.start(tempo_letra)

func _on_tempo_mostrando_timeout() -> void:
	_mostrar_letra()
