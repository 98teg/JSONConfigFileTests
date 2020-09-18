extends JSONConfigProcessor


func _postprocess(maximum : int):
	set_variable("max", maximum)

	return maximum
