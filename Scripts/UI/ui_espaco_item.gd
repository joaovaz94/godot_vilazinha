extends Panel

@onready var sprite_fundo: Sprite2D = $Fundo_Item
@onready var sprite_item: Sprite2D = $CenterContainer/Panel/Imagem_item

func update(espaco: EspacoInventario):
	if !espaco.item:
		sprite_fundo.frame = 0
		sprite_item.visible = false
	else:
		sprite_fundo.frame = 1
		sprite_item.visible = true
		sprite_item.texture = espaco.item.textura
		
