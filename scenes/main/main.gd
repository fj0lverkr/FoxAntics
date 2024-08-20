extends CanvasLayer

@onready var high_score_label: Label = $VBoxContainer/HBoxContainer/HSLabel

func _ready() -> void:
	Engine.time_scale = 1
	var hs: int = ScoreManager.get_high_score()
	if hs > 0:
		high_score_label.text = str(hs)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("up"):
		GameManager.load_next_level()

	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
