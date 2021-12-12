extends RigidBody2D

export(NodePath) var score
export(NodePath) var playerState

export(Array, PackedScene) var monsterPrefabs

var resetRequested = false

func _on_Wall_of_Doom_body_entered(body):
	if body.name == "Player 1":
		body.die()
		get_node(score).player2_score += 1
	elif body.name == "Player 2":
		body.die()
		get_node(score).player1_score += 1
	elif "Turret" in body.name:
		body.explode()
	else:
		body.queue_free()
		#$Hit1.play()

func request_reset():
	resetRequested = true

func _integrate_forces(state):
	if get_node(playerState).anyPlayerDying() or resetRequested:
		if resetRequested:
			var screen = get_viewport().size
			var shape  = get_node("Hitbox").shape.extents
			var pos    = Vector2((screen.x - shape.x) / 2, screen.y / 2)
			state.transform = Transform2D(0, pos)
			resetRequested = false
			
		state.linear_velocity = Vector2()
		state.angular_velocity = 0

func decorate_with_monsters():
	var height = $Hitbox.shape.extents.y
	var density = 50
	for y in height / density:
		var monsterPrefab = monsterPrefabs[randi() % monsterPrefabs.size()]
		var monster = monsterPrefab.instance()
		var pixelX = (randi() % int($Hitbox.shape.extents.x)) - 16
		var pixelY = height / 2 - y * density
		monster.position = Vector2(pixelX, pixelY)
		monster.rotation = PI * (randi() % 380) / 180
		add_child(monster)

func _ready():
	decorate_with_monsters()
