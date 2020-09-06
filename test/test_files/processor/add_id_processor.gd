extends JSONConfigProcessor


func _process(dic : Dictionary):
	if not has_variable("id"):
		dic.id = 0
		set_variable("id", 0)
	else:
		var id = get_variable("id") + 1
		dic.id = id
		set_variable("id", id)

	return dic
