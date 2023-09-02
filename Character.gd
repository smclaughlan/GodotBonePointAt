extends Node3D

@onready var look_at_target = get_parent().get_node("LookTarget")
@onready var player_skeleton = $playermesh/playerrig/Skeleton3D
@onready var upper_body = player_skeleton.find_bone("spine.003")


func _process(delta):
	# If the target is behind us, do nothing.
	var player_vec = global_position.direction_to(Vector3(global_position.x, global_position.y, global_position.z - 1))
	var dir_to_targ = global_position.direction_to(look_at_target.global_position)
	var dotprod = player_vec.dot(dir_to_targ)
	# <0 or >0 will be in front/behind.
#	print('dotprod: ', dotprod) # should be -1 to 1
	if dotprod > 0:
		var quat = Quaternion(Vector3(0, 0, 1), 0)
		player_skeleton.set_bone_pose_rotation(upper_body, quat)
		return
	# Otherwise do the look at behavior.
	var angle1 = global_transform.origin.direction_to(look_at_target.global_transform.origin)
	# Be careful about which axis is set to 1.
	var quat = Quaternion(Vector3(0, 0, 1), angle1)
	player_skeleton.set_bone_pose_rotation(upper_body, quat)
