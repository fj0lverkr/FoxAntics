extends Node2D

@onready var player: Player = $"Player"
@onready var player_cam: Camera2D = $"PlayerCam"

func _physics_process(_delta: float) -> void:
	player_cam.position = player.position
	if Input.is_action_just_pressed("up") and GameManager.get_game_state() == GameManager.GAME_STATE.OVER:
		GameManager.call_deferred("load_main_scene")