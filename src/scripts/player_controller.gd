extends Node2D

enum Player{
	PLAYER1, PLAYER2
}

export(Player) var player
export(float) var moveSpeed = 700.0
export(NodePath) var turretContainer
export(NodePath) var energyIndicator
export(PackedScene) var turretPrefab

var energy = 100.0
var energyRecoveryRate = 10.0

const TURRET1_COST = 30.0
const TURRET2_COST = 50.0
const TURRET3_COST = 70.0

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

func turret_cost(turretType):
	match turretType:
		Turret.Turret.TURRET1:
			return TURRET1_COST
		Turret.Turret.TURRET2:
			return TURRET2_COST
		Turret.Turret.TURRET3:
			return TURRET3_COST

func spawn_turret(turretType):
	var turret = turretPrefab.instance()
	turret.position = position
	get_node(turretContainer).add_child(turret)
	energy = energy - turret_cost(turretType)

func process_turret_input():
	match player:
		Player.PLAYER1:
			if Input.is_action_just_pressed("player1_place_turret1") and energy >= TURRET1_COST:
				spawn_turret(Turret.Turret.TURRET1)
			if Input.is_action_just_pressed("player1_place_turret2") and energy >= TURRET2_COST:
				spawn_turret(Turret.Turret.TURRET2)
			if Input.is_action_just_pressed("player1_place_turret3") and energy >= TURRET3_COST:
				spawn_turret(Turret.Turret.TURRET3)
		Player.PLAYER2:
			if Input.is_action_just_pressed("player2_place_turret1") and energy >= TURRET1_COST:
				spawn_turret(Turret.Turret.TURRET1)
			if Input.is_action_just_pressed("player2_place_turret2") and energy >= TURRET2_COST:
				spawn_turret(Turret.Turret.TURRET2)
			if Input.is_action_just_pressed("player2_place_turret3") and energy >= TURRET3_COST:
				spawn_turret(Turret.Turret.TURRET3)

func update_energy():
	get_node(energyIndicator).value = energy
	
func recover_energy(delta):
	if energy < 100:
		energy = energy + delta * energyRecoveryRate
	else:
		energy = 100

func _process(delta):
	position.x += getXInput() * moveSpeed * delta
	position.y += getYInput() * moveSpeed * delta
	recover_energy(delta)
	process_turret_input()
	update_energy()
