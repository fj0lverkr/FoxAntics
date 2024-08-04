extends Enemy

@onready var floor_detection: RayCast2D = $"FloorDetection"
@onready var animated_sprite: AnimatedSprite2D = $"AnimatedSprite2D"

func _physics_process(delta: float) -> void:
	super._physics_process(delta)

	if not is_on_floor():
		velocity.y += gravity * delta
		print("test")
	else:
		velocity.x = speed * facing

	move_and_slide()

	if is_on_floor():
		if is_on_wall() or not floor_detection.is_colliding():
			_flip()

func _flip() -> void:
	animated_sprite.flip_h = not animated_sprite.flip_h
	floor_detection.position.x = floor_detection.position.x * -1
	if facing == FACING.LEFT:
		facing = FACING.RIGHT
	else:
		facing = FACING.LEFT