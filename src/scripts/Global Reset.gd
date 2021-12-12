extends Node

export(NodePath) var player1
export(NodePath) var player2
export(NodePath) var wall
export(NodePath) var turretContainer

const PLAYER_X_OFF = 150

var timePlayed = 0

func global_reset():
	timePlayed = 0
	
	var screen = get_viewport().size
	
	var player1_node = get_node(player1)
	var player2_node = get_node(player2)
	var wall_node    = get_node(wall)
	var turrets_node = get_node(turretContainer)
	
	wall_node.request_reset()
	player1_node.spawn()
	player2_node.spawn()
	
	var player1_shape = player1_node.get_node("Hitbox").shape
	var player2_shape = player2_node.get_node("Hitbox").shape
	
	player1_node.position = Vector2(           PLAYER_X_OFF, (screen.y - player1_shape.height) / 2)
	player2_node.position = Vector2(screen.x - PLAYER_X_OFF, (screen.y - player2_shape.height) / 2)
	
	player1_node.energy = 100
	player2_node.energy = 100
	
	for c in turrets_node.get_children():
		turrets_node.remove_child(c)
		c.queue_free()

func _ready():
	global_reset()
	
func _process(delta):
	timePlayed += delta
