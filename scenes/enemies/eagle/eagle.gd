extends Enemy

@onready var animated_sprite: AnimatedSprite2D = $"AnimatedSprite2D"
@onready var turn_timer: Timer = $"TurnTimer"
@onready var player_detector: Area2D = $"PlayerDetector"
@onready var shooter: Shooter = $"Shooter"

const FLY_SPEED: Vector2 = Vector2(35, 15)

var _fly_direction: Vector2 = Vector2.ZERO
var _can_shoot: bool = false

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	velocity = _fly_direction
	_shoot()

	move_and_slide()

func _flip() -> void:
	var x_dir: float = sign(_player_ref.global_position.x - global_position.x)
	if x_dir >= 0:
		animated_sprite.flip_h = true
		facing = FACING.RIGHT
	else:
		animated_sprite.flip_h = false
		facing = FACING.LEFT

	_fly_direction = Vector2(x_dir, 1) * FLY_SPEED

func fly() -> void:
	_flip()
	turn_timer.start()

func _shoot() -> void:
	if _can_shoot:
		shooter.shoot(global_position.direction_to(_player_ref.global_position))

func _on_turn_timer_timeout() -> void:
	fly()

func _on_screen_entered() -> void:
	animated_sprite.play("fly")
	fly()

func _on_player_detector_area_entered(_area: Area2D) -> void:
	_can_shoot = true

func _on_player_detector_area_exited(_area: Area2D) -> void:
	_can_shoot = false