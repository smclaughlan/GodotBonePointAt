extends Node3D

@onready var barrel_override: BoneAttachment3D = $Graphics/chaingun/BarrelOverride
var barrel_spin_speed: float = 0.0
var barrel_spin_speed_max: float = 20.0


func _process(delta: float) -> void:
	if Input.is_action_pressed("leftmouse"):
		barrel_spin_speed = clampf(barrel_spin_speed + 0.5, 0.0, barrel_spin_speed_max)
		if barrel_spin_speed == barrel_spin_speed_max:
			print("firing!")
		else:
			print("not firing yet...")
	else:
		barrel_spin_speed = clampf(barrel_spin_speed - 0.3, 0.0, barrel_spin_speed_max)
	barrel_override.rotate_z(deg_to_rad(barrel_spin_speed))
