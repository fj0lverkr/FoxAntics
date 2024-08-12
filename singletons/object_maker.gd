extends Node

enum BULLET {PLAYER, ENEMY}
enum SCENE {EXPLOSION, PICKUP}

const BULLETS: Dictionary = {
	BULLET.PLAYER: preload("res://scenes/bullets/player_bullet/player_bullet.tscn"),
	BULLET.ENEMY: preload("res://scenes/bullets/enemy_bullet/enemy_bullet.tscn")
}

const SCENES: Dictionary = {
	SCENE.EXPLOSION: preload("res://scenes/enemy_explosion/enemy_explosion.tscn"),
	SCENE.PICKUP: preload("res://scenes/pick_up/pick_up.tscn")
}


const BG_FILES: Dictionary = {
	1: [
		preload("res://assets/backgrounds/game_background_1/layers/sky.png"),
		preload("res://assets/backgrounds/game_background_1/layers/clouds_1.png"),
		preload("res://assets/backgrounds/game_background_1/layers/clouds_2.png"),
		preload("res://assets/backgrounds/game_background_1/layers/clouds_3.png"),
		preload("res://assets/backgrounds/game_background_1/layers/clouds_4.png"),
		preload("res://assets/backgrounds/game_background_1/layers/rocks_1.png"),
		preload("res://assets/backgrounds/game_background_1/layers/rocks_2.png")
	],
	2: [
		preload("res://assets/backgrounds/game_background_2/layers/sky.png"),
		preload("res://assets/backgrounds/game_background_2/layers/birds.png"),
		preload("res://assets/backgrounds/game_background_2/layers/clouds_1.png"),
		preload("res://assets/backgrounds/game_background_2/layers/clouds_2.png"),
		preload("res://assets/backgrounds/game_background_2/layers/clouds_3.png"),
		preload("res://assets/backgrounds/game_background_2/layers/pines.png"),
		preload("res://assets/backgrounds/game_background_2/layers/rocks_1.png"),
		preload("res://assets/backgrounds/game_background_2/layers/rocks_2.png"),
		preload("res://assets/backgrounds/game_background_2/layers/rocks_3.png")
	],
	3: [
		preload("res://assets/backgrounds/game_background_3/layers/sky.png"),
		preload("res://assets/backgrounds/game_background_3/layers/clouds_1.png"),
		preload("res://assets/backgrounds/game_background_3/layers/clouds_2.png"),
		preload("res://assets/backgrounds/game_background_3/layers/ground_1.png"),
		preload("res://assets/backgrounds/game_background_3/layers/ground_2.png"),
		preload("res://assets/backgrounds/game_background_3/layers/ground_3.png"),
		preload("res://assets/backgrounds/game_background_3/layers/plant.png"),
		preload("res://assets/backgrounds/game_background_3/layers/rocks.png")
	],
	4: [
		preload("res://assets/backgrounds/game_background_4/layers/sky.png"),
		preload("res://assets/backgrounds/game_background_4/layers/clouds_1.png"),
		preload("res://assets/backgrounds/game_background_4/layers/clouds_2.png"),
		preload("res://assets/backgrounds/game_background_4/layers/ground.png"),
		preload("res://assets/backgrounds/game_background_4/layers/rocks.png")
	]
}

func _add_child(child: Node) -> void:
	get_tree().root.add_child(child)

func _call_add_child(child: Node) -> void:
	call_deferred("_add_child", child)

func create_bullet(direction: Vector2, life_span: float, speed: float, position: Vector2, key: BULLET) -> void:
	var new_bullet: Bullet = BULLETS[key].instantiate()
	new_bullet.setup(direction, life_span, speed)
	new_bullet.global_position = position
	_call_add_child(new_bullet)

func create_scene(key: SCENE, position: Vector2) -> void:
	var new_scene: Node = SCENES[key].instantiate()
	new_scene.global_position = position
	_call_add_child(new_scene)
