extends CharacterBody2D

class_name Player

@onready var sprite: Sprite2D = $"Sprite2D"
@onready var animation_player: AnimationPlayer = $"AnimationPlayer"

var gravity: float = ProjectSettings.get("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()