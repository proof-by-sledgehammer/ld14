extends RigidBody2D

export(NodePath) var score
export(NodePath) var reset

var resetRequested = false

func _on_Wall_of_Doom_body_entered(body):
	if body.name == "Player 1":
		get_node(score).player2_score += 1
		get_node(reset).global_reset()
	elif body.name == "Player 2":
		get_node(score).player1_score += 1
		get_node(reset).global_reset()
	else:
		body.queue_free()
		#$Hit1.play()

func request_reset():
	resetRequested = true

func _integrate_forces(state):
	if resetRequested:
		var screen = get_viewport().size
		var shape  = get_node("Hitbox").shape.extents
		var pos    = Vector2((screen.x - shape.x) / 2, screen.y / 2)
		
		state.transform = Transform2D(0, pos)
		state.linear_velocity = Vector2()
		state.angular_velocity = 0
		resetRequested = false
