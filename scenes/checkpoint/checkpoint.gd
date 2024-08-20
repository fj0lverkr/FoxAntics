extends Area2D

class_name Checkpoint

const TRIGGER: String = "parameters/conditions/on_trigger"

@onready var state_machine: AnimationTree = $"AnimationTree"
@onready var sound: AudioStreamPlayer2D = $"Sound"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.on_boss_killed.connect(_on_boss_killed)

func _on_boss_killed(_points: int) -> void:
	if not state_machine[TRIGGER]:
		state_machine[TRIGGER] = true
		monitoring = true
		SoundManager.play_sound_2d(sound, SoundManager.CHECKPOINT)

func _on_area_entered(_area: Area2D) -> void:
	SignalBus.on_level_finished.emit()
	SoundManager.play_sound_2d(sound, SoundManager.YOU_WIN)
	GameManager.call_deferred("load_next_level")
