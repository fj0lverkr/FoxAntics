extends Node

signal on_enemy_hit(points: int)
signal on_pickup_taken(points: int)
signal on_boss_killed(points: int)
signal on_score_updated(score: int)
signal on_player_hit(lives: int, do_camera_shake: bool)
signal on_level_started(lives: int)
signal on_game_over()