extends JSONConfigProcessor


func _process(maximum : int):
	set_variable("max", maximum)

	return maximum
