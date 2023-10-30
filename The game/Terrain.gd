extends MeshInstance3D


@export var height_map = Texture2D.new();
@export var HeightScale  = 3.0;
@export var ColiderSize : int = 100;
var HeightMap = Image.new();
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

var redy = false;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !redy:
		redy = true;
		get_surface_override_material(0).set("shader_param/HeightMap",height_map)
		get_surface_override_material(0).set("shader_param/HeightScale",HeightScale)
		
		HeightMap = height_map.get_image()
		HeightMap.decompress();
		HeightMap.INTERPOLATE_BILINEAR;
		HeightMap.convert(Image.FORMAT_RF)
		HeightMap.resize(ColiderSize,ColiderSize)
		HeightMap.clear_mipmaps()
		
		var data = HeightMap.get_data().to_float32_array()
		print("x" + str(HeightMap.get_width()) + "   y" + str(HeightMap.get_height()))
		
		print(data.size())
		
		$StaticBody3D/CollisionShape3D.shape.map_width = ColiderSize;
		$StaticBody3D/CollisionShape3D.shape.map_depth = ColiderSize;
		print($StaticBody3D/CollisionShape3D.shape.map_data.size())
		for i in range(0,data.size()):
			$StaticBody3D/CollisionShape3D.shape.map_data[i] = data[i] * HeightScale
		
		
		#$StaticBody3D/CollisionShape3D.scale = Vector3(mesh.size.x/HeightMap.get_width(),1,mesh.size.y/HeightMap.get_height())
		
	pass
