extends Node2D

export(int) var player1_score = 0
export(int) var player2_score = 0

export(NodePath) var player1_score_text
export(NodePath) var player2_score_text

func _process(_delta):
	get_node(player1_score_text).text = player1_score as String
	get_node(player2_score_text).text = player2_score as String
