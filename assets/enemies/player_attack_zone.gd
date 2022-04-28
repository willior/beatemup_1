extends Area2D

var player = null
var last_known_location = null

onready var attackZone = $CollisionShape2D

func can_attack_player():
	return player != null

func _on_PlayerAttackZone_body_entered(body):
	player = body

func _on_PlayerAttackZone_body_exited(body):
	player = null
	last_known_location = body.global_position
