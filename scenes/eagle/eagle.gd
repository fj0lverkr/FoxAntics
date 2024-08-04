extends Enemy

@onready var animated_sprite: AnimatedSprite2D = $"AnimatedSprite2D"
@onready var turn_timer: Timer = $"TurnTimer"
@onready var player_detector: RayCast2D = $"PlayerDetector"

const FLY_SPEED: Vector2 = Vector2(35, 15)

var _fly_direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	velocity = _fly_direction

	move_and_slide()

func _flip() -> void:
	var x_dir: float = sign(_player_ref.global_position.x - global_position.x)
	if x_dir > 0:
		animated_sprite.flip_h = true
		facing = FACING.RIGHT
	else:
		animated_sprite.flip_h = false
		facing = FACING.LEFT

	_fly_direction = Vector2(x_dir, 1) * FLY_SPEED

func fly() -> void:
	_flip()
	turn_timer.start()

func _on_turn_timer_timeout() -> void:
	fly()

func _on_screen_entered() -> void:
	animated_sprite.play("fly")
	fly()