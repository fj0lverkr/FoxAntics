extends Camera2D

class_name PlayerCamera

@onready var shake_timer: Timer = $"ShakeTimer"

@export var shake_amount: float = 5.0

func _ready() -> void:
    set_process(false)
    SignalBus.on_player_hit.connect(_on_player_hit)

func _process(_delta: float) -> void:
    offset = _get_random_offset()

func _get_random_offset() -> Vector2:
    return Vector2(
        randf_range(-shake_amount, shake_amount),
        randf_range(-shake_amount, shake_amount)
    )

func _on_player_hit(_lives: int, do_camera_shake: bool) -> void:
    if not do_camera_shake:
        return
    set_process(true)
    shake_timer.start()

func _on_shake_timer_timeout() -> void:
    set_process(false)
    offset = Vector2.ZERO
