extends Node2D

class_name Shooter

@onready var sound: AudioStreamPlayer2D = $"Sound"
@onready var shoot_timer: Timer = $"ShootTimer"

@export var speed: float = 50.0
@export var life_span: float = 10.0
@export var bullet_type: ObjectMaker.BULLET
@export var shoot_delay: float = 0.7

var _can_shoot: bool = true

func _ready() -> void:
	shoot_timer.wait_time = shoot_delay

func shoot(direction: Vector2) -> void:
	if not _can_shoot:
		return
	
	_can_shoot = false
	SoundManager.play_sound_2d(sound, SoundManager.LASER)
	ObjectMaker.create_bullet(direction, life_span, speed, global_position, bullet_type)
	shoot_timer.start()

func _on_shoot_timer_timeout() -> void:
	_can_shoot = true