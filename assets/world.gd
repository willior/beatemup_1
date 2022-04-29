extends Node2D

func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()

func toggle_multiplayer_gui():
	print('toggle_multiplayer_gui')
