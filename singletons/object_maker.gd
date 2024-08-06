extends Node

enum BULLET {PLAYER, ENEMY}

const BULLETS = {
	BULLET.PLAYER: preload("res://scenes/bullets/player_bullet/player_bullet.tscn"),
	BULLET.ENEMY: preload("res://scenes/bullets/enemy_bullet/enemy_bullet.tscn")
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