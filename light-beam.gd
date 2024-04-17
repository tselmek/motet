extends Node3D

@export var BeamColor: Color

const MAX_LENGTH := 50.0

@onready var Raycast := $Raycast
@onready var BeamMesh := $BeamMesh

@onready var origin = BeamMesh.position

# Called when the node enters the scene tree for the first time.
func _ready():
	if BeamColor:
		var newMaterial = StandardMaterial3D.new()
		newMaterial.albedo_color = Color(BeamColor, 0.5)
		BeamMesh.material_override = newMaterial


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	var collision_point
	var midway_point
	Raycast.force_raycast_update()
	
	if Raycast.is_colliding():
		collision_point = Raycast.to_local(Raycast.get_collision_point())
		
		BeamMesh.mesh.height = collision_point.y
		midway_point = (origin + collision_point) / 2
		BeamMesh.position.y = midway_point.y
	
	else:
		BeamMesh.mesh.height = MAX_LENGTH
		BeamMesh.position.y = MAX_LENGTH / 2
