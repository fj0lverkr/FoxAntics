extends Control

@onready var hb_hearts: HBoxContainer = $MC/HB/HBHearts
@onready var overlay: ColorRect = $Overlay
@onready var vb_game_over: VBoxContainer = $Overlay/VBGameOver
@onready var vb_level_complete: VBoxContainer = $Overlay/VBLevelComplete
@onready var label_score: Label = $MC/HB/ScoreLabel

var _hearts: Array[Node]

func _ready() -> void:
	overlay.hide()
	vb_game_over.hide()
	vb_level_complete.hide()
	SignalBus.on_player_hit.connect(_update_hearts_on_hit)
	SignalBus.on_level_started.connect(_update_hearts)
	SignalBus.on_game_over.connect(_on_game_over)
	SignalBus.on_score_updated.connect(_on_score_updated)
	_hearts = hb_hearts.get_children()

func _update_hearts_on_hit(lives: int, _b: bool) -> void:
	_update_hearts(lives)

func _update_hearts(lives: int) -> void:
	for life in range(_hearts.size()):
		_hearts[life].visible = lives > life

func _on_game_over() -> void:
	overlay.show()
	vb_game_over.show()

func _on_score_updated(score: int) -> void:
	label_score.text = str(score)