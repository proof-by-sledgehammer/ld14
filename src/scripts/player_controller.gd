extends Node2D

enum Player{
	PLAYER1, PLAYER2
}

export(Player) var player
export(float) var moveSpeed = 700.0

func getXInput():
	match player:
		Player.PLAYER1:
			return Input.get_action_strength("player1_move_right") - Input.get_action_strength("player1_move_left")
		Player.PLAYER2:
			return Input.get_action_strength("player2_move_right") - Input.get_action_strength("player2_move_left")

func getYInput():
	match player:
		Player.PLAYER1:
			return Input.get_action_strength("player1_move_down") - Input.get_action_strength("player1_move_up")
		Player.PLAYER2:
			return Input.get_action_strength("player2_move_down") - Input.get_action_strength("player2_move_up")	

func _process(delta):
	position.x += getXInput() * moveSpeed * delta
	position.y += getYInput() * moveSpeed * delta
