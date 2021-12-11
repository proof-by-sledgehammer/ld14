extends Node2D

var segment = preload("res://prefabs/wall of doom - segment.tscn")

################################################################################
# CREATTION
################################################################################

func attach_segment(root, pos):
	var newSegment = segment.instance()
	var joint = PinJoint2D.new()
	
	add_child(newSegment)
	add_child(joint)
	
	newSegment.position = pos
	
	joint.node_a = root.get_path()
	joint.node_b = newSegment.get_path()
	
	return newSegment

func attach_initial_segments_in_direction(root, num_segments, y_direction):
	for n in num_segments:
		var x = root.position.x
		var y = root.position.y + 2 * y_direction * root.get_node("Hitbox").shape.extents.y
		root = attach_segment(root, Vector2(x, y))

func create_initial_segments():
	var root = segment.instance()
	add_child(root)
	attach_initial_segments_in_direction(root, 10, +1)
	attach_initial_segments_in_direction(root, 10, -1)

func _ready():
	create_initial_segments()
