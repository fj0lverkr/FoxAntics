extends Area2D

class_name PickUp

@onready var animated_sprite: AnimatedSprite2D = $"AnimatedSprite2D"

const VARIANTS: Array[String] = ["melon", "cherry", "kiwi", "banana"]
const POINTS: int = 2
const JUMP: float = -80.0
const GRAVITY: float = 130

var _start_pos_y: float
var _speed_y: float = JUMP
var _stopped: bool = false

func _ready() -> void:
    _start_pos_y = global_position.y
    animated_sprite.play(VARIANTS.pick_random())

func _process(delta: float) -> void:
    if _stopped:
        return
    position.y += _speed_y * delta
    _speed_y += GRAVITY * delta
    _stopped = global_position.y >= _start_pos_y

func remove() -> void:
    set_process(false)
    hide()
    queue_free()

func _on_life_timer_timeout() -> void:
    remove()