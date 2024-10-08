extends CharacterBody2D

class_name Enemy

const OFF_SCREEN: float = 1000.0

enum FACING {LEFT = -1, RIGHT = 1}

@export var default_facing: FACING = FACING.LEFT
@export var points: int = 1
@export var speed: float = 30.0

var gravity: float = 800.0
var facing: FACING = default_facing
var _player_ref: Player
var _dead: bool = false

func _ready() -> void:
	if not get_tree().get_nodes_in_group(Constants.GROUP_PLAYER).is_empty():
		_player_ref = get_tree().get_nodes_in_group(Constants.GROUP_PLAYER).front()

func _physics_process(_delta: float) -> void:
	_check_off_screen()

func _check_off_screen() -> void:
	if global_position.y > OFF_SCREEN:
		queue_free()

func _die() -> void:
	if _dead:
		return
	_dead = true
	SignalBus.on_enemy_hit.emit(points)
	set_physics_process(false)
	hide()
	ObjectMaker.create_scene(ObjectMaker.SCENE.EXPLOSION, global_position)
	queue_free()

func _on_screen_entered() -> void:
	pass # To override.

func _on_screen_exited() -> void:
	pass # To verride.


func _on_hit_box_area_entered(_area: Area2D) -> void:
	_die()
