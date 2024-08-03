extends Node

const BOSS_ARRIVE = "boss_arrive"
const CHECKPOINT = "ckeckpoint"
const DAMAGE = "damage"
const FARM_FROLICS = "farm_frolics"
const FLOWING_ROCKS = "flowing_rocks"
const GAME_OVER = "game_over"
const IMPACT = "impact"
const JUMP = "jump"
const LAND = "land"
const LASER = "laser"
const PHASE_JUMP = "phase_jump"
const PICKUP = "pickup"
const PICKUP3 = "pickup3"
const PICKUP5 = "pickup5"
const YOU_WIN = "you_win"

const SOUNDS: Dictionary = {
    BOSS_ARRIVE: preload("res://assets/sound/boss_arrive.wav"),
    CHECKPOINT: preload("res://assets/sound/checkpoint.wav"),
    DAMAGE: preload("res://assets/sound/damage.wav"),
    FARM_FROLICS: preload("res://assets/sound/Farm Frolics.ogg"),
    FLOWING_ROCKS: preload("res://assets/sound/Flowing Rocks.ogg"),
    GAME_OVER: preload("res://assets/sound/game_over.ogg"),
    IMPACT: preload("res://assets/sound/impact.wav"),
    JUMP: preload("res://assets/sound/jump.wav"),
    LAND: preload("res://assets/sound/land.wav"),
    LASER: preload("res://assets/sound/laser.wav"),
    PHASE_JUMP: preload("res://assets/sound/phaseJump1.ogg"),
    PICKUP: preload("res://assets/sound/pickup.wav"),
    PICKUP3: preload("res://assets/sound/pickup3.ogg"),
    PICKUP5: preload("res://assets/sound/pickup5.ogg"),
    YOU_WIN: preload("res://assets/sound/you_win.ogg")
}

func play_sound_2d(player: AudioStreamPlayer2D, stream_name: String) -> void:
    if not SOUNDS.has(stream_name):
        return
    if player.playing:
        player.stop()
    player.stream = SOUNDS[stream_name]
    player.play()

func play_sound(player: AudioStreamPlayer, stream_name: String) -> void:
    if not SOUNDS.has(stream_name):
        return
    if player.playing:
        player.stop()
    player.stream = SOUNDS[stream_name]
    player.play()