extends AnimatedSprite2D

class_name EnemyExplosion

func _on_animation_finished() -> void:
	queue_free()
