extends Node

const DEFAULT_MOVEMENT_SPEED = 100
const DEFAULT_ACCELERATION = 800
const DEFAULT_FRICTION = 1000

var movement_speed
var acceleration
var friction

var max_health = 100
var health = max_health
var strength = 4

func _ready():
	movement_speed = DEFAULT_MOVEMENT_SPEED
	acceleration = DEFAULT_ACCELERATION
	friction = DEFAULT_FRICTION
