extends Node

const SCORE_PATH: String = "user://foxygamescores.json"
const MAX_SCORES: int = 10

var _score: int = 0
var _score_history: Array = []

func _ready() -> void:
    _reset_score()
    SignalBus.on_boss_killed.connect(_on_points_added)
    SignalBus.on_enemy_hit.connect(_on_points_added)
    SignalBus.on_pickup_taken.connect(_on_points_added)
    SignalBus.on_game_over.connect(_on_game_over)
    _load_score()

func _on_points_added(points: int) -> void:
    _score += points
    SignalBus.on_score_updated.emit(_score)

func _on_game_over() -> void:
    _score_history.append({"score": _score})
    _save_score()

func _load_score() -> void:
    if not FileAccess.file_exists(SCORE_PATH):
        return
    var file: FileAccess = FileAccess.open(SCORE_PATH, FileAccess.READ)
    var text: String = file.get_as_text()
    if not text or text.length() <= 0:
        return
    _score_history = JSON.parse_string(text)
    file.close()

func _save_score() -> void:
    _score_history.sort_custom(_sort_scores)
    if _score_history.size() > MAX_SCORES:
        _score_history = _score_history.slice(0, MAX_SCORES)
    var file: FileAccess = FileAccess.open(SCORE_PATH, FileAccess.WRITE)
    if file:
        file.store_string(JSON.stringify(_score_history))
        file.close()


func _reset_score() -> void:
    _score = 0

func _sort_scores(a: Dictionary, b: Dictionary) -> bool:
    return a.score > b.score

func get_score() -> int:
    return _score