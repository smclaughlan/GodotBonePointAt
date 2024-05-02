extends Node3D

@onready var chaingun: Node3D = $Graphics/chaingun
@onready var chaingunbarrels: Node3D = $Graphics/chaingunbarrels
@onready var barrels_inner: BoneAttachment3D = $Graphics/chaingun/Armature/Skeleton3D/BarrelsInner
@onready var barrels_outer: BoneAttachment3D = $Graphics/chaingun/Armature/Skeleton3D/BarrelsOuter
@onready var base: BoneAttachment3D = $Graphics/chaingunbarrels/Armature/Skeleton3D/Base
@onready var grip: BoneAttachment3D = $Graphics/chaingunbarrels/Armature/Skeleton3D/Grip
var barrel_spin_speed: float = 0.0
var barrel_spin_speed_max: float = 20.0

func _ready() -> void:
	barrels_inner.hide()
	barrels_outer.hide()
	base.hide()
	grip.hide()


func _process(delta: float) -> void:
	if Input.is_action_pressed("leftmouse"):
		barrel_spin_speed = clampf(barrel_spin_speed + 0.5, 0.0, barrel_spin_speed_max)
		if barrel_spin_speed == barrel_spin_speed_max:
			print("firing!")
		else:
			print("not firing yet...")
	else:
		barrel_spin_speed = clampf(barrel_spin_speed - 0.3, 0.0, barrel_spin_speed_max)
	chaingunbarrels.rotate_z(deg_to_rad(barrel_spin_speed))
