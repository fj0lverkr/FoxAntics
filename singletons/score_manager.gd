extends Node

var _score: int = 0

func _ready() -> void:
    SignalBus.on_boss_killed.connect(_on_points_added)
    SignalBus.on_enemy_hit.connect(_on_points_added)
    SignalBus.on_pickup_taken.connect(_on_points_added)

func _on_points_added(points: int) -> void:
    _score += points
    SignalBus.on_score_updated.emit(_score)
