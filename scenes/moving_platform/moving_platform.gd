extends AnimatableBody2D

class_name MovingPlatform

@export var p1: Marker2D
@export var p2: Marker2D
@export var speed: float = 50.0

var _time_to_move: float = 0.0
var _tween: Tween

func _ready() -> void:
	_set_time_to_move()
	_set_moving()

func _exit_tree() -> void:
	_tween.kill()

func _set_time_to_move() -> void:
	var delta: float = p1.global_position.distance_to(p2.global_position)
	_time_to_move = delta / speed

func _set_moving() -> void:
	_tween = get_tree().create_tween()
	_tween.set_loops()
	_tween.tween_property(self, "global_position", p1.global_position, _time_to_move)
	_tween.tween_property(self, "global_position", p2.global_position, _time_to_move)