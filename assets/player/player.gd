extends KinematicBody2D

var stats = P1Stats
var velocity = Vector2()
var dir_vector = Vector2()
var player_inputs = {
	"left": "p1_left",
	"right": "p1_right",
	"up": "p1_up",
	"down": "p1_down",
	"attack": "p1_attack1"
}

enum {
	MOVE,
	ATTACK
}
var state = MOVE

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var hitbox = $HitboxPivot/Hitbox
onready var hurtbox = $Hurtbox

func _ready():
	animationTree.active = true

func _physics_process(delta):
	match state:
		MOVE: move_state(delta)
		ATTACK: attack_state(delta)

func _input(event):
	match state:
		MOVE:
			if event.is_action_pressed(player_inputs.attack) and !event.is_echo():
				animationState.travel("Punch1")
				state = ATTACK
		ATTACK:
			pass

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength(player_inputs.right) - Input.get_action_strength(player_inputs.left)
	input_vector.y = Input.get_action_strength(player_inputs.down) - Input.get_action_strength(player_inputs.up)
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		dir_vector = input_vector
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, stats.friction * delta)
	velocity = velocity.move_toward(input_vector * stats.movement_speed, stats.acceleration * delta)
	h_flip_handler(input_vector.x)
	move()

func move():
	velocity = move_and_slide(velocity)

func h_flip_handler(direction):
	if direction < 0:
		sprite.flip_h = true
		$HitboxPivot.rotation_degrees = 180
	elif direction > 0:
		sprite.flip_h = false
		$HitboxPivot.rotation_degrees = 0

func attack_state(delta):
	velocity = velocity.move_toward(Vector2.ZERO, (stats.friction) * delta)
	move()

func attack_1():
	hitbox.attack_1()

func attack_animation_finished():
	# print('attack_animation_finished')
	state = MOVE
