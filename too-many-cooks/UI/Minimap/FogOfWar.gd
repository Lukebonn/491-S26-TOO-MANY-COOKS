'''extends TextureRect

@export var cell_size: int = 64
@export var reveal_radius: int = 3

var fog_image: Image
var fog_texture: ImageTexture
var grid_size: Vector2i
var player: CharacterBody2D
var map_size: Vector2
var map_offset: Vector2

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	
	await get_tree().process_frame
	await get_tree().process_frame
	
	var tilemap = get_tree().get_root().find_child("TileMap", true, false)
	if tilemap:
		var rect = tilemap.get_used_rect()
		var tile_size = tilemap.tile_set.tile_size
		map_offset = Vector2(rect.position) * Vector2(tile_size)
		map_size = Vector2(rect.size) * Vector2(tile_size)
	else:
		map_size = Vector2(2000, 2000)
		map_offset = Vector2.ZERO
	
	if not player:
		return
	
	grid_size = Vector2i(
		int(map_size.x / cell_size),
		int(map_size.y / cell_size)
	)
	
	fog_image = Image.create(grid_size.x, grid_size.y, false, Image.FORMAT_L8)
	fog_image.fill(Color(0, 0, 0, 1))
	
	fog_texture = ImageTexture.create_from_image(fog_image)
	material.set_shader_parameter("fog_texture", fog_texture)
	
	var white_image = Image.create(258, 258, false, Image.FORMAT_RGBA8)
	white_image.fill(Color(1, 1, 1, 1))
	texture = ImageTexture.create_from_image(white_image)

func _process(_delta):
	if not player or not fog_texture:
		return
	
	var cell = Vector2i(
		int((player.global_position.x - map_offset.x) / cell_size),
		int((player.global_position.y - map_offset.y) / cell_size)
	)
	
	for x in range(-reveal_radius, reveal_radius + 1):
		for y in range(-reveal_radius, reveal_radius + 1):
			var target = cell + Vector2i(x, y)
			if target.x >= 0 and target.x < grid_size.x and target.y >= 0 and target.y < grid_size.y:
				fog_image.set_pixel(target.x, target.y, Color(1, 1, 1, 1))
	
	fog_texture.update(fog_image)
	material.set_shader_parameter("fog_texture", fog_texture)


'''
extends TextureRect

@export var cell_size: int = 64
@export var reveal_radius: int = 3

var fog_image: Image
var fog_texture: ImageTexture
var grid_size: Vector2i
var player: CharacterBody2D
var map_size: Vector2
var map_offset: Vector2

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	
	await get_tree().process_frame
	await get_tree().process_frame
	
	var tilemap = get_tree().get_root().find_child("TileMap", true, false)
	if tilemap:
		var rect = tilemap.get_used_rect()
		var tile_size = tilemap.tile_set.tile_size
		map_offset = Vector2(rect.position) * Vector2(tile_size)
		map_size = Vector2(rect.size) * Vector2(tile_size)
	else:
		map_size = Vector2(2000, 2000)
		map_offset = Vector2.ZERO
	
	if not player:
		return
	
	grid_size = Vector2i(
		int(map_size.x / cell_size),
		int(map_size.y / cell_size)
	)
	
	fog_image = Image.create(grid_size.x, grid_size.y, false, Image.FORMAT_L8)
	fog_image.fill(Color(0, 0, 0, 1))
	
	fog_texture = ImageTexture.create_from_image(fog_image)
	material.set_shader_parameter("fog_texture", fog_texture)
	
	var white_image = Image.create(258, 258, false, Image.FORMAT_RGBA8)
	white_image.fill(Color(1, 1, 1, 1))
	texture = ImageTexture.create_from_image(white_image)

func _process(_delta):
	if not player or not fog_texture:
		return
	
	var cell = Vector2i(
		int((player.global_position.x - map_offset.x) / cell_size),
		int((player.global_position.y - map_offset.y) / cell_size)
	)
	
	for x in range(-reveal_radius, reveal_radius + 1):
		for y in range(-reveal_radius, reveal_radius + 1):
			var target = cell + Vector2i(x, y)
			if target.x >= 0 and target.x < grid_size.x and target.y >= 0 and target.y < grid_size.y:
				fog_image.set_pixel(target.x, target.y, Color(1, 1, 1, 1))
	
	fog_texture.update(fog_image)
	material.set_shader_parameter("fog_texture", fog_texture)
	#'''
