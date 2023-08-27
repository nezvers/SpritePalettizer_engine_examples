extends Sprite

var index:int = 0
const PALETTE_COUNT:int = 4

func _on_Timer_timeout():
	index = (index + 1) % PALETTE_COUNT	# simple cycling through indexes 0 -> 3
	material.set_shader_param("palette_index", index)
