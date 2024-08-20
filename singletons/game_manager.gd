extends Node

const TOTAL_LEVELS: int = 3
const MAIN_SCENE: PackedScene = preload("res://scenes/main/main.tscn")

enum GAME_STATE {MENU, RUNNING, PAUSED, OVER}

var _current_level: int = 0
var _level_scenes: Dictionary = {}
var _current_state: GAME_STATE = GAME_STATE.MENU

var _player_lives: int = 0

func _ready() -> void:
    _load_level_scenes()
    call_deferred("load_main_scene")
    SignalBus.on_game_over.connect(_on_game_over)
    SignalBus.on_level_finished.connect(_on_level_finished)

func _load_level_scenes() -> void:
    for l in range(1, TOTAL_LEVELS + 1):
        _level_scenes[l] = load("res://scenes/level_base/levels/level_%s.tscn" % l)

func load_main_scene() -> void:
    ScoreManager._reset_score()
    _current_level = 0
    _player_lives = 0
    _current_state = GAME_STATE.MENU
    get_tree().change_scene_to_packed(MAIN_SCENE)

func _set_next_level() -> void:
    pause_game(false)
    _current_level += 1
    if _current_level > TOTAL_LEVELS:
        _current_level = 1

func _on_game_over() -> void:
    pause_game(true)
    _current_state = GAME_STATE.OVER
    Engine.time_scale = 0

func _on_level_finished() -> void:
    pause_game(true)

func pause_game(is_pause: bool) -> void:
    for p in get_tree().get_nodes_in_group(Constants.GROUP_PLAYER):
        p.set_process(!is_pause)
        p.set_physics_process(!is_pause)
    for m in get_tree().get_nodes_in_group(Constants.GROUP_MOVABLES):
        m.set_process(!is_pause)
        m.set_physics_process(!is_pause)
    _current_state = GAME_STATE.PAUSED if is_pause else GAME_STATE.RUNNING

func load_next_level() -> void:
    _set_next_level()
    get_tree().change_scene_to_packed(_level_scenes[_current_level])

func get_game_state() -> GAME_STATE:
    return _current_state

func get_player_lives() -> int:
    return _player_lives

func set_player_lives(l: int) -> void:
    _player_lives = l