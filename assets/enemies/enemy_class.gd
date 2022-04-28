extends KinematicBody2D

var ENEMY_NAME
var ACCELERATION
var MAX_SPEED
var WANDER_SPEED
var ATTACK_SPEED
var FRICTION
var WANDER_TARGET_RANGE
var ATTACK_TARGET_RANGE

enum {
	IDLE,
	WANDER,
	CHASE,
	WINDUP,
	ATTACK,
	DEAD,
	STUN
}

var state = IDLE
var evasion_bonus = 0

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

var attacking = false
var attack_on_cooldown = false
var target

var common_drop_name : String
var common_drop_chance : float
var rare_drop_name : String
var rare_drop_chance : float

onready var stats = $EnemyStats
onready var sprite = $Sprite
onready var hitbox = $HitboxPivot/Hitbox
onready var hurtbox = $Hurtbox
onready var playerDetectionZone = $PlayerDetectionZone
onready var playerAttackZone = $PlayerAttackZone
onready var tween = $Tween

func _ready():
	add_to_group("Enemies")

func h_flip_handler():
	sprite.flip_h = velocity.x < 0

func accelerate_towards_point(point, speed, speed_mod, delta):
	var direction = global_position.direction_to(point) # gets the direction by grabbing the target position, the point argument
	velocity = velocity.move_toward(direction * (speed*speed_mod), (ACCELERATION*speed_mod) * delta) # multiplies that by the speed argument
	h_flip_handler()

func disable_detection():
	playerAttackZone.set_deferred("monitoring", false)
	playerDetectionZone.set_deferred("monitoring", false)
	playerAttackZone.player = null
	playerDetectionZone.player = null

func enable_detection():
	playerAttackZone.set_deferred("monitoring", true)
	playerDetectionZone.set_deferred("monitoring", true)

func enable_attack_zone():
	playerAttackZone.set_deferred("monitoring", true)

func disable_attack_zone():
	playerAttackZone.set_deferred("monitoring", false)

func pick_random_state(state_list): 
	state_list.shuffle() # shuffles the order of the list of states recieved
	return state_list.pop_front() # spits one out

func hurtbox_entered(damage_source):
# warning-ignore:unused_variable
	var player = damage_source.get_parent().get_parent()
	var damage = damage_source.attack_power
	var hitstun_duration = damage_source.get("hitstun_duration")
	deal_damage(damage)
	if stats.health > 0:
		knockback = damage_source.knockback_vector
		tween.interpolate_property(sprite,
		"modulate",
		Color(1, 0.8, 0),
		Color(1, 1, 1),
		0.2,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
		)
		tween.start()
		return [damage, hitstun_duration]
	else:
		knockback = damage_source.knockback_vector * 160 # knockback velocity on kill
		return [damage, hitstun_duration]

func deal_damage(damage):
	damage = min(damage, 9999)
	stats.health -= damage
