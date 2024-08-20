extends Node2D

class_name BossEnemy

const TRIGGER: String = "parameters/conditions/on_trigger"

@onready var state_machine: AnimationTree = $"AnimationTree"
@onready var state_machine_playback: AnimationNodeStateMachinePlayback = $AnimationTree["parameters/playback"]
@onready var visuals: Node2D = $"Visuals"
@onready var hitbox: Area2D = $Visuals/Hitbox
@onready var hitbox_shape: CollisionShape2D = $Visuals/Hitbox/CollisionShape2D

@export var lives: int = 2
@export var points: int = 5

var _invincible: bool = false
var _tween: Tween

func tween_hit() -> void:
	_tween = get_tree().create_tween()
	_tween.tween_property(visuals, "position", Vector2.ZERO, 1.0)

func reduce_lives() -> void:
	lives -= 1
	if lives <= 0:
		SignalBus.on_boss_killed.emit(points)
		set_process(false)
		_tween.kill()
		queue_free()

func set_invincible(v: bool) -> void:
	_invincible = v
	if v:
		state_machine_playback.travel("hurt")
	
func take_damage() -> void:
	if _invincible:
		return
	set_invincible(true)
	tween_hit()
	reduce_lives()

func _on_trigger_area_entered(_area: Area2D) -> void:
	if not state_machine[TRIGGER]:
		state_machine[TRIGGER] = true
		hitbox.set_deferred("monitoring", true)
		hitbox_shape.set_deferred("disabled", false)

func _on_hitbox_area_entered(_area: Area2D) -> void:
	take_damage()
