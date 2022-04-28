extends Node

export var max_health : int
var health = max_health setget set_health
export var defense : float
export var experience_pool : int

signal no_health
signal health_changed(value)

func _ready():
	self.health = max_health

func set_health(value):
	health = value
	health = clamp(value, 0, max_health)
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")
