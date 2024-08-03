extends CharacterBody2D

class_name Player

@onready var sprite: Sprite2D = $"Sprite2D"
@onready var animation_player: AnimationPlayer = $"AnimationPlayer"
@onready var audio_player: AudioStreamPlayer2D = $"Audio"
@onready var debug_label: Label = $"DebugLabel"

const RUN_SPEED: float = 120.0
const MAX_FALL_SPEED: float = 400.0
const HURT_TIME: float = 0.3
const JUMP_VELOCITY: float = -400.0

enum PLAYER_STATE {IDLE, RUNNING, FALLING, JUMPING, HURT}
enum PLAYER_DIRECTION {LEFT, RIGHT}

var _gravity: float = ProjectSettings.get("physics/2d/default_gravity")
var _player_state: PLAYER_STATE = PLAYER_STATE.IDLE
var _player_direction: PLAYER_DIRECTION = PLAYER_DIRECTION.RIGHT

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += _gravity * delta

	_get_input()
	move_and_slide()
	_calculate_state()
	_update_debug_label()

func _get_input() -> void:
	velocity.x = 0
	if Input.is_action_pressed("left"):
		velocity.x = -RUN_SPEED
		_player_direction = PLAYER_DIRECTION.LEFT
	elif Input.is_action_pressed("right"):
		velocity.x = RUN_SPEED
		_player_direction = PLAYER_DIRECTION.RIGHT
	
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	velocity.y = clampf(velocity.y, JUMP_VELOCITY, MAX_FALL_SPEED)
		

func _calculate_state() -> void:
	if _player_state == PLAYER_STATE.HURT:
		return

	if is_on_floor():
		if velocity.x == 0:
			set_state(PLAYER_STATE.IDLE)
		else:
			set_state(PLAYER_STATE.RUNNING)
	else:
		if velocity.y >= 0:
			set_state(PLAYER_STATE.FALLING)
		else:
			set_state(PLAYER_STATE.JUMPING)

func set_state(new_state: PLAYER_STATE) -> void:
	if new_state == _player_state:
		return

	if _player_state == PLAYER_STATE.FALLING and (new_state == PLAYER_STATE.IDLE or new_state == PLAYER_STATE.RUNNING):
		SoundManager.play_sound_2d(audio_player, SoundManager.LAND)

	_player_state = new_state

	match _player_state:
		PLAYER_STATE.IDLE:
			animation_player.play("idle")
		PLAYER_STATE.RUNNING:
			animation_player.play("run")
		PLAYER_STATE.JUMPING:
			animation_player.play("jump")
			SoundManager.play_sound_2d(audio_player, SoundManager.JUMP)
		PLAYER_STATE.FALLING:
			animation_player.play("fall")
			
	sprite.flip_h = _player_direction == PLAYER_DIRECTION.LEFT

func _update_debug_label() -> void:
	debug_label.text = "%s\n%s\n%.0f, %.0f" % [
		"on floor" if is_on_floor() else "in air",
		PLAYER_STATE.keys()[_player_state].to_lower(),
		velocity.x,
		velocity.y
	]