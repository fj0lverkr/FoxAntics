extends ParallaxBackground

class_name ScrollingBackground

@export_range(1, 4) var level: int = 1
@export var mirror_x: float = 1440.0
@export var sprite_offset: Vector2 = Vector2(0.0, -540.0)
@export var sprite_scale: Vector2 = Vector2(0.75, 0.75)

func _ready() -> void:
	_setup()

func _get_increment() -> float:
	return 1.0 / ObjectMaker.BG_FILES[level].size()

func _add_sprite(t: Texture2D) -> Sprite2D:
	var sprite: Sprite2D = Sprite2D.new()
	sprite.texture = t
	sprite.offset = sprite_offset
	sprite.scale = sprite_scale
	return sprite

func _add_layer(t: Texture2D, o: float) -> void:
	var l: ParallaxLayer = ParallaxLayer.new()
	var s: Sprite2D = _add_sprite(t)
	l.add_child(s)
	l.motion_mirroring.x = mirror_x
	l.motion_scale.x = o
	add_child(l)

func _setup() -> void:
	var increment: float = _get_increment()
	var motion_offset: float = increment
	var files: Array = ObjectMaker.BG_FILES[level]
	for index in range(files.size()):
		var file: Texture2D = files[index]
		if index == 0:
			_add_layer(file, 1)
		else:
			_add_layer(file, motion_offset)
			motion_offset += increment
