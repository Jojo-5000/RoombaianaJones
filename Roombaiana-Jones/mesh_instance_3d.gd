extends MeshInstance3D

@onready var ray_origin = Vector3(0, 0, 0)
@onready var ray_direction = Vector3(0, 0, -1)  # The direction of the ray
var ray_length = 10.0

@onready var mesh_instance = $MeshInstance3D  # Assuming a MeshInstance3D node is a child of the current node

func _ready():
	# Create a cylinder mesh for the ray
	var cylinder = CylinderMesh.new()
	cylinder.radial_segments = 8  # The width of the ray (adjust as needed)
	cylinder.height = ray_length  # The length of the ray
	
	# Set the mesh of the MeshInstance3D node to our cylinder mesh
	mesh_instance.mesh = cylinder
	
	# Position the mesh at the ray's origin
	mesh_instance.transform.origin = ray_origin
	
	# Rotate the cylinder to align with the ray's direction
	mesh_instance.transform.basis = Basis().looking_at(ray_direction, Vector3.UP)

func _process(delta):
	# Update the cylinder's length and direction based on the ray
	var ray_end = ray_origin + ray_direction.normalized() * ray_length
	mesh_instance.transform.origin = ray_origin
	mesh_instance.transform.basis = Basis().looking_at(ray_direction, Vector3.UP)
	mesh_instance.scale = Vector3(1, ray_length, 1)  # Adjust the scale to represent the ray's length
