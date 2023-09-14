extends Node3D

@onready var look_at_target = get_parent().get_node("LookTarget")
@onready var player_skeleton = $"char2graphics/basehuman_control_rig-noimp_deform/Skeleton3D"
@onready var upper_body = player_skeleton.find_bone("DEF-spine.002")


func _process(delta):
	# If the target is behind us, do nothing.
	var player_vec = transform.basis.z
	var dir_to_targ = global_position.direction_to(look_at_target.global_position)
	var dotprod = player_vec.dot(dir_to_targ)
#	<0 or >0 will be in front/behind.
#    print('dotprod: ', dotprod) # should be -1 to 1
	if dotprod < 0:
		var quat = Quaternion(Vector3(0, 0, 1), 0)
		# Smoothly transition with a tween.
		var tween = get_tree().create_tween()
		tween.tween_property(player_skeleton, "bones/" + str(upper_body) + "/rotation", quat, 1)
		# Or instantly snap.
#		player_skeleton.set_bone_pose_rotation(upper_body, quat)
		return
	# Otherwise do the look at behavior
	var angle1 = player_skeleton.get_bone_global_pose(upper_body).origin.direction_to(to_local(look_at_target.global_position))
	# Be careful about which axis is set to 1.
	var quat = Quaternion(Vector3(0, 0, 1), angle1)
	
	# Smoothly transition with a tween.
	var tween = get_tree().create_tween()
	tween.tween_property(player_skeleton, "bones/" + str(upper_body) + "/rotation", quat, 1)
	# Or instantly snap.
#	player_skeleton.set_bone_pose_rotation(upper_body, quat)
