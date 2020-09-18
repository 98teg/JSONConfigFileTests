extends JSONConfigProcessor


func _postprocess(minimum : int):
	set_variable("min", minimum)

	return minimum
