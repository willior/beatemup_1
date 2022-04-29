extends Node

var multiplayer_2 = false

var player1
var player2
var player3
var player4

signal player1_initialized()
signal player2_initialized()
signal player3_initialized()
signal player4_initialized()

func initialize_player(player_name):
	match player_name:
		"Player1":
			player1 = get_tree().get_root().get_node("/root/World/YSort/Player1")
			emit_signal("player1_initialized", player1)
		"Player2":
			player2 = get_tree().get_root().get_node("/root/World/YSort/Player2")
			emit_signal("player2_initialized", player2)
		"Player3":
			player3 = get_tree().get_root().get_node("/root/World/YSort/Player3")
			emit_signal("player3_initialized", player3)
		"Player4":
			player4 = get_tree().get_root().get_node("/root/World/YSort/Player4")
			emit_signal("player4_initialized", player4)

func multiplayer_2_toggle():
	if multiplayer_2: # OFF TOGGLE
		if player2.state != 0 or player2.dying:
			print('player2 tried quitting while not idle; returning')
			return
		var REMOTE2D = load("res://assets/system/RemoteTransform2D.tscn")
		var remoteTransform2D = REMOTE2D.instance()
		player1.add_child(remoteTransform2D)
		get_tree().get_root().get_node("/root/World/Camera2D").multiplayer_2_toggle()
		player2.queue_free()
		multiplayer_2 = false
		player2 = null
	else: # ON TOGGLE
		multiplayer_2 = true
		player1.get_node("RemoteTransform2D").queue_free()
		load_player2()
		get_tree().get_root().get_node("/root/World/YSort").add_child(player2)
		# get_tree().get_root().get_node("/root/World/Camera2D").state = 1
		get_tree().get_root().get_node("/root/World/Camera2D").multiplayer_2_toggle()
		player2.global_position = player1.global_position
	get_tree().get_root().get_node("/root/World/GUI").toggle_multiplayer_gui()

func load_player2():
	player2 = load("res://assets/player/player.tscn").instance()
	player2.name = "Player2"
	player2.stats = P2Stats
	player2.get_node("Sprite").texture = load("res://assets/player/player2.png")
	player2.player_inputs = {
		"left": "left_2",
		"right": "right_2",
		"up": "up_2",
		"down": "down_2",
		"attack": "attack_2",
		"roll": "roll_2",
		"examine": "examine_2",
		"alchemy": "alchemy_2",
		"previous": "previous_2",
		"next": "next_2",
		"start": "start_2",
		"select": "select_2"
	}
	return player2
