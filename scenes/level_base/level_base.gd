extends Node2D

@onready var player: CharacterBody2D = $"Player"
@onready var player_cam: Camera2D = $"PlayerCam"

func _ready() -> void:
	SignalBus.on_game_over.connect(_on_game_over)

func _physics_process(_delta: float) -> void:
	player_cam.position = player.position

func _on_game_over() -> void:
	for p in get_tree().get_nodes_in_group(Constants.GROUP_PLAYER):
		p.set_process(false)
		p.set_physics_process(false)
	for m in get_tree().get_nodes_in_group(Constants.GROUP_MOVABLES):
		m.set_process(false)
		m.set_physics_process(false)