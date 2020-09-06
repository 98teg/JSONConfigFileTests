extends JSONConfigProcessor


func _process(_value):
	if has_variable("min"):
		get_property().set_min_value(get_variable("min"))
	if has_variable("max"):
		get_property().set_max_value(get_variable("max"))
