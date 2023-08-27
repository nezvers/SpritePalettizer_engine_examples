extends Sprite2D

# for example enabled texture filtering - Nearest

var index:int = 0
const PALETTE_COUNT:int = 4

func _on_Timer_timeout():
	index = (index + 1) % PALETTE_COUNT	# simple cycling through indexes 0 -> 3
	(material as ShaderMaterial).set_shader_parameter("index", index)
