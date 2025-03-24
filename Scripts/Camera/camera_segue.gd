extends Camera2D

@export var jogador: CharacterBody2D
@export var tilemap: TileMapLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var map_rect = tilemap.get_used_rect()
	var tile_size = tilemap.rendering_quadrant_size
	var world_size = map_rect.size * tile_size
	
	limit_right = world_size.x
	limit_bottom = world_size.y
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position = jogador.position

func get_camera_rect() -> Rect2:
	var pos = global_position # Camera's center
	var half_size = get_viewport_rect().size * 0.5
	return Rect2(pos - half_size, pos + half_size)

func vec_inside_camera(ponto: Vector2) -> bool:
	var cam_rec = get_camera_rect()
	return ponto.x < cam_rec.position.y && ponto.x > cam_rec.position.x && ponto.y < cam_rec.size.x && ponto.y > cam_rec.size.y  

func esta_nos_limites(p: Vector2) -> bool:
	return p.x > limit_left && p.x < limit_right && p.y > limit_top && p.y < limit_bottom
