extends Node3D

@onready var look_at_target = get_parent().get_node("LookTarget")
@onready var player_skeleton = $"char2graphics/basehuman_control_rig-noimp_deform/Skeleton3D"
@onready var upper_body = player_skeleton.find_bone("DEF-spine.002")


func _process(delta):
	# If the target is behind us, do nothing.
	var player_vec = transform.basis.z
	var dir_to_targ = global_position.direction_to(look_at_target.global_position)
	var dotprod = player_vec.dot(dir_to_targ)
	if dotprod < 0:
		# Tween back to base rotation.
		var quat = Quaternion(Vector3(0, 0, 1), 0)
#		# Smoothly transition with a tween.
		var tween = get_tree().create_tween()
		tween.tween_property(player_skeleton, "bones/" + str(upper_body) + "/rotation", quat, 1)
		# Or instantly snap.
#		player_skeleton.set_bone_pose_rotation(upper_body, quat)
		return
	# Rotate and tween to look at target.
	var lookRotation = player_skeleton.get_bone_global_pose_no_override(upper_body)
	lookRotation = lookRotation.looking_at(to_local(look_at_target.global_position), Vector3(0, 1, 0), true)
	# Snap
#	player_skeleton.set_bone_global_pose_override(upper_body, lookRotation, 1.0, true)
	# Or tween.
	var tween = get_tree().create_tween()
	tween.tween_property(player_skeleton, "bones/" + str(upper_body) + "/rotation", Quaternion(lookRotation.basis), 1)
