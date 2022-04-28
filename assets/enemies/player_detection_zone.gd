extends Area2D

var player = null

onready var detectionZone = $CollisionShape2D

func can_see_player():
	return player != null

func _on_PlayerDetectionZone_body_entered(body):
	if body.z_index == get_parent().z_index:
		player = body
		detectionZone.scale = Vector2(2, 2)

func _on_PlayerDetectionZone_body_exited(_body):
	player = null
	detectionZone.scale = Vector2(1, 1)
