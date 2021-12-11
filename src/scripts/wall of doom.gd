extends RigidBody2D

func _on_Wall_of_Doom_body_entered(body):
	body.queue_free()
