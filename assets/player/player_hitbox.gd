extends Area2D

var attack_power : int = 4
var attack_modifier : float = 1
var knockback_vector = Vector2.ZERO
var knockback_modifier : float = 1
var stats

func _ready():
	stats = get_parent().get_parent().stats
	attack_power = stats.strength

func enable_hitbox(time=0.1):
	set_deferred("monitorable", true)
	$HitboxTimer.start(time)
	yield($HitboxTimer, "timeout")
	set_deferred("monitorable", false)

func attack_1():
	attack_audio()
	knockback_vector = (get_parent().get_parent().dir_vector / 2) * knockback_modifier
	enable_hitbox()

func attack_audio():
	pass
