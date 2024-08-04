extends CharacterBody2D

class_name Enemy

const OFF_SCREEN: float = 1000.0

enum FACING {LEFT = -1, RIGHT = 1}

@export var default_facing: FACING = FACING.LEFT
@export var points: int = 1

var _speed: float = 30.0
var _gravity: float = 800.0
var _facing: FACING = default_facing
var _player_ref: Player
var _dead: bool = false

func _ready() -> void:
	if not get_tree().get_nodes_in_group(GameManager.GROUP_PLAYER).is_empty():
		_player_ref = get_tree().get_nodes_in_group(GameManager.GROUP_PLAYER).front()


func _physics_process(_delta: float) -> void:
	_check_off_screen()

func _check_off_screen() -> void:
	if global_position.y > OFF_SCREEN:
		queue_free()

func _die() -> void:
	if _dead:
		return
	_dead = true
	SignalBus.on_enemy_hit.emit(points, global_position)
	set_physics_process(false)
	hide()
	queue_free()

func _on_screen_entered() -> void:
	pass # To override.

func _on_screen_exited() -> void:
	pass # To verride.
