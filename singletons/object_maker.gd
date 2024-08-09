extends Node

enum BULLET {PLAYER, ENEMY}
enum SCENE {EXPLOSION, PICKUP}

const BULLETS = {
	BULLET.PLAYER: preload("res://scenes/bullets/player_bullet/player_bullet.tscn"),
	BULLET.ENEMY: preload("res://scenes/bullets/enemy_bullet/enemy_bullet.tscn")
}

const SCENES = {
	SCENE.EXPLOSION: preload("res://scenes/enemy_explosion/enemy_explosion.tscn"),
	SCENE.PICKUP: preload("res://scenes/pick_up/pick_up.tscn")
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
