extends Node2D

class_name BossEnemy

const TRIGGER: String = "parameters/conditions/on_trigger"
const HIT: String = "parameters/conditions/on_hit"

@onready var state_machine: AnimationTree = $"AnimationTree"
@onready var visuals: Node2D = $"Visuals"

@export var lives: int = 2
@export var points: int = 5

var _invincible: bool = false

func tween_hit() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(visuals, "position", Vector2.ZERO, 1.0)

func reduce_lives() -> void:
	lives -= 1
	if lives < 0:
		SignalBus.on_boss_killed.emit(points)
		set_process(false)
		queue_free()

func set_invincible(v: bool) -> void:
	_invincible = v
	state_machine[HIT] = v
	
func take_damage() -> void:
	if _invincible:
		return
	set_invincible(true)
	tween_hit()
	reduce_lives()

func _on_trigger_area_entered(_area: Area2D) -> void:
	if not state_machine[TRIGGER]:
		state_machine[TRIGGER] = true

func _on_hitbox_area_entered(_area: Area2D) -> void:
	take_damage()
