extends Node

signal on_enemy_hit(points: int, position: Vector2)
signal on_pickup_taken(points: int)
signal on_boss_killed(points: int)
signal on_player_hit(lives: int)
signal on_level_started(lives: int)
signal on_game_over()