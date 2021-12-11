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

var lookDirection = Direction.Direction.NORTH
var walkDirection = Direction.Direction.NORTH

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
	turret.turret = turretType
	turret.shootDirection = Direction.to_vec(lookDirection)
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
		
func process_look_direction():
	match player:
		Player.PLAYER1:
			var mousePos = get_global_mouse_position()
			var lookAt = mousePos - position
			lookDirection = Direction.from_vec(lookAt)
		Player.PLAYER2:
			# TODO: Somehow left-right and up-down are switched
			# Not sure if I messed up `from_vec` or there are problems with `get_axis`
			var x = Input.get_axis("player2_look_left", "player2_look_right")
			var y = Input.get_axis("player2_look_up", "player2_look_down")
			if x != 0 or y != 0:
				lookDirection = Direction.from_vec(Vector2(y, x))

func process_movement(delta):
	position.x += getXInput() * moveSpeed * delta
	position.y += getYInput() * moveSpeed * delta

func _ready():
	match player:
		Player.PLAYER1:
			lookDirection = Direction.Direction.EAST
		Player.PLAYER2:
			lookDirection = Direction.Direction.WEST

func _process(delta):
	process_movement(delta)
	recover_energy(delta)
	process_look_direction()
	process_turret_input()
	update_energy()
