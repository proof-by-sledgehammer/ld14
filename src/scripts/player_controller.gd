extends Node2D

enum Player{
	PLAYER1, PLAYER2
}

export(Player) var player
export(float) var moveSpeed = 700.0
export(NodePath) var turretContainer
export(PackedScene) var turretPrefab

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

func spawn_turret():
	var turret = turretPrefab.instance()
	turret.position = position
	get_node(turretContainer).add_child(turret)

func process_turret_input():
	match player:
		Player.PLAYER1:
			if Input.is_action_just_pressed("player1_place_turret1"):
				spawn_turret()
			if Input.is_action_just_pressed("player1_place_turret2"):
				spawn_turret()
			if Input.is_action_just_pressed("player1_place_turret3"):
				spawn_turret()
		Player.PLAYER2:
			if Input.is_action_just_pressed("player2_place_turret1"):
				spawn_turret()
			if Input.is_action_just_pressed("player2_place_turret2"):
				spawn_turret()
			if Input.is_action_just_pressed("player2_place_turret3"):
				spawn_turret()

func _process(delta):
	position.x += getXInput() * moveSpeed * delta
	position.y += getYInput() * moveSpeed * delta
	process_turret_input()
