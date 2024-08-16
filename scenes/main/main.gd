extends CanvasLayer

func _ready() -> void:
	Engine.time_scale = 1

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("up"):
		GameManager.load_next_level()
