extends JSONConfigProcessor


func _process(minimum : int):
	set_variable("min", minimum)

	return minimum
