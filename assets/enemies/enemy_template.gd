extends "res://assets/enemies/enemy_class.gd"

onready var delayTimer = $DelayTimer
onready var attackTimer = $AttackController/Timer
onready var cooldownTimer = $CooldownTimer
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController
onready var attackController = $AttackController
onready var animationPlayer = $AnimationPlayer
onready var audio = $AudioStreamPlayer2D

func _init():
	ENEMY_NAME = "Idiot"
	ACCELERATION = 256
	MAX_SPEED = 32
	WANDER_SPEED = 16
	ATTACK_SPEED = 96
	FRICTION = 200
	WANDER_TARGET_RANGE = 4
	ATTACK_TARGET_RANGE = 4
	common_drop_name = "Rock"
	common_drop_chance = 0.50
	rare_drop_name = "Water"
	rare_drop_chance = 0.125

func attack_finish():
	print(ENEMY_NAME, ': attack_finish()')
	pass

func _on_Hurtbox_area_entered(area):
	var hit_data = hurtbox_entered(area)

func _on_EnemyStats_no_health():
	queue_free()
