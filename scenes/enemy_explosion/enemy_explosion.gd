extends AnimatedSprite2D

class_name EnemyExplosion

func _on_animation_finished() -> void:
	ObjectMaker.create_scene(ObjectMaker.SCENE.PICKUP, global_position)
	queue_free()
