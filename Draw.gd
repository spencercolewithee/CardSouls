extends TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	#rect_scale *= (($'../../'.CardSize/rect_size) * 0.8)
	rect_scale *= $'../../'.CardSize/rect_size
