extends Enemy

@onready var animated_sprite: AnimatedSprite2D = $"AnimatedSprite2D"
@onready var jump_timer: Timer = $"JumpTimer"

const JUMP_VELOCITY: Vector2 = Vector2(150, -200)
const JUMP_WAIT_RANGE: Vector2 = Vector2(2.5, 5.0)

var _jump: bool = false
var _seen_player: bool = false

func _ready() -> void:
	super._ready()
	_start_timer()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.x = 0
		animated_sprite.play("idle")

	_apply_jump()
	move_and_slide()
	_flip()

func _start_timer() -> void:
	jump_timer.wait_time = randf_range(JUMP_WAIT_RANGE.x, JUMP_WAIT_RANGE.y)
	jump_timer.start()

func _apply_jump() -> void:
	if not is_on_floor() or not _seen_player or not _jump:
		return
	
	velocity = JUMP_VELOCITY
	velocity.x *= facing
	_jump = false
	animated_sprite.play("jump")
	_start_timer()

	
func _flip() -> void:
	if _player_ref.global_position.x > global_position.x:
		animated_sprite.flip_h = true
		facing = FACING.RIGHT
	else:
		animated_sprite.flip_h = false
		facing = FACING.LEFT

func _on_jump_timer_timeout() -> void:
	_jump = true

func _on_screen_entered() -> void:
	_seen_player = true

func _on_screen_exited() -> void:
	_seen_player = false
