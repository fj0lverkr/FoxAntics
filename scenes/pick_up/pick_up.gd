extends RigidBody2D

class_name PickUp

@onready var animated_sprite: AnimatedSprite2D = $"AnimatedSprite2D"

const VARIANTS: Array[String] = ["melon", "cherry", "kiwi", "banana"]
const POINTS: int = 2
const JUMP: float = -10.0
const GRAVITY: float = 130

var _start_pos_y: float
var _speed_y: float = JUMP
var _motion: Vector2 = Vector2.ZERO

func _ready() -> void:
    _start_pos_y = global_position.y
    animated_sprite.play(VARIANTS.pick_random())

func _process(delta: float) -> void:
    _motion.y += _speed_y * delta
    _speed_y += GRAVITY * delta
    move_and_collide(_motion)

func remove() -> void:
    set_process(false)
    hide()
    queue_free()

func _on_life_timer_timeout() -> void:
    remove()

func _on_area_entered(_area: Area2D) -> void:
    SignalBus.on_pickup_taken.emit(POINTS)
    remove()
