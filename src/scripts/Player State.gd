extends Node2D

export var player1Dying = false
export var player2Dying = false

func anyPlayerDying():
	return player1Dying or player2Dying
