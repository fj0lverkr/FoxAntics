extends Node

const TOTAL_LEVELS: int = 3
const MAIN_SCENE: PackedScene = preload("res://scenes/main/main.tscn")

var _current_level: int = 0
var _level_scenes: Dictionary = {}

func _ready() -> void:
    _load_level_scenes()
    call_deferred("_load_main_scene")
    SignalBus.on_game_over.connect(_on_game_over)

func _load_level_scenes() -> void:
    for l in range(1, TOTAL_LEVELS + 1):
        _level_scenes[l] = load("res://scenes/level_base/levels/level_%s.tscn" % l)

func _load_main_scene() -> void:
    _current_level = 0
    get_tree().change_scene_to_packed(MAIN_SCENE)

func _set_next_level() -> void:
    _current_level += 1
    if _current_level > TOTAL_LEVELS:
        _current_level = 1

func _on_game_over() -> void:
    Engine.time_scale = 0

func load_next_level() -> void:
    _set_next_level()
    get_tree().change_scene_to_packed(_level_scenes[_current_level])