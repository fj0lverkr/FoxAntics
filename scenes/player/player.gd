extends CharacterBody2D

class_name Player

@onready var sprite: Sprite2D = $"Sprite2D"
@onready var animation_player: AnimationPlayer = $"AnimationPlayer"

const RUN_SPEED: float = 120.0
const MAX_FALL_SPEED: float = 400.0
const HURT_TIME: float = 0.3
const JUMP_VELOCITY: float = -400.0

enum PLAYER_STATE {IDLE, RUNNING, FALLING, JUMPING, HURT}

var _gravity: float = ProjectSettings.get("physics/2d/default_gravity")
var _player_state: PLAYER_STATE = PLAYER_STATE.IDLE

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += _gravity * delta

	_get_input()
	move_and_slide()

func _get_input() -> void:
	velocity.x = 0
	if Input.is_action_pressed("left"):
		velocity.x = -RUN_SPEED
	elif Input.is_action_pressed("right"):
		velocity.x = RUN_SPEED
	
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	velocity.y = clampf(velocity.y, JUMP_VELOCITY, MAX_FALL_SPEED)

func _calculate_state() -> void:
	if _player_state == PLAYER_STATE.HURT:
		return