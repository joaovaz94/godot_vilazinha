extends CanvasLayer

@onready var inventario = $Inventario
@onready var menu_missoes = $menu_missoes
@onready var menu_jogo = $menuJogo

@onready var tab_inventario = $tabInventario
@onready var tab_missoes = $tabMissoes
@onready var tab_menu = $tabMenu

@onready var cobre_tab_missoes: ColorRect = $cobreTabMissoes
@onready var cobre_tab_inventario: ColorRect = $cobreTabInventario
@onready var cobre_tab_menu: ColorRect = $cobreTabMenu

func _ready() -> void:
	inventario.fechar()
	menu_missoes.fechar()
	menu_jogo.fechar()
	esconder_tabs()

func _input(event):
	if event.is_action_pressed("inventario"):
		if inventario.esta_aberto:
			inventario.fechar()
			menu_missoes.fechar()
			esconder_tabs()
		else:
			inventario.abrir()
			mostrar_tabs()
			destacar_tab("inventario")

	if event.is_action_pressed("missoes"):
		if menu_missoes.esta_aberto:
			menu_missoes.fechar()
			inventario.fechar()
			esconder_tabs()
		else:
			menu_missoes.abrir()
			mostrar_tabs()
			destacar_tab("missoes")
	
	if !menu_jogo.esta_aberto && !menu_missoes.esta_aberto && !inventario.esta_aberto && event.is_action_pressed("fechar_ui"):
		menu_jogo.abrir()
		mostrar_tabs()
		destacar_tab("menu")
	elif (inventario.esta_aberto || menu_missoes.esta_aberto || menu_jogo.esta_aberto) && event.is_action_pressed("fechar_ui"):
		menu_missoes.fechar()
		inventario.fechar()
		menu_jogo.fechar()
		esconder_tabs()

	if inventario.esta_aberto && event.is_action_pressed("mudar_menu"):
		inventario.fechar()
		menu_jogo.abrir()
		destacar_tab("menu")
	elif menu_jogo.esta_aberto && event.is_action_pressed("mudar_menu"):
		menu_jogo.fechar()
		menu_missoes.abrir()
		destacar_tab("missoes")
	elif menu_missoes.esta_aberto && event.is_action_pressed("mudar_menu"):
		menu_missoes.fechar()
		inventario.abrir()
		destacar_tab("inventario")
	


func mostrar_tabs():
	tab_missoes.visible = true
	tab_menu.visible = true
	tab_inventario.visible = true

func esconder_tabs():
	tab_missoes.visible = false
	tab_menu.visible = false
	tab_inventario.visible = false
	
	cobre_tab_missoes.visible = false
	cobre_tab_menu.visible = false
	cobre_tab_inventario.visible = false

func destacar_tab(destaque: String):
	match destaque:
		"inventario":
			cobre_tab_inventario.visible = false
			cobre_tab_menu.visible = true
			cobre_tab_missoes.visible = true
		"menu":
			cobre_tab_inventario.visible = true
			cobre_tab_menu.visible = false
			cobre_tab_missoes.visible = true
		"missoes":
			cobre_tab_inventario.visible = true
			cobre_tab_menu.visible = true
			cobre_tab_missoes.visible = false
