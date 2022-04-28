extends "res://assets/player/playerstats.gd"

func save():
	var player1_stats = {
		
	}
	var save_dict = {
		"player1_stats": player1_stats
	}
	return save_dict
