extends Area2D

func remove() -> void:
    set_process(false)
    hide()
    queue_free()

func _on_life_timer_timeout() -> void:
    remove()