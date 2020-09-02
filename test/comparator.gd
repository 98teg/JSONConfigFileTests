class_name Comparator

static func are_equal(value_1, value_2) -> bool:
	if typeof(value_1) != typeof(value_2):
		return false

	if typeof(value_1) == TYPE_REAL:
		return _are_equal_floats(value_1, value_2)
	elif typeof(value_1) == TYPE_ARRAY:
		return _are_equal_arrays(value_1, value_2)
	elif typeof(value_1) == TYPE_DICTIONARY:
		return _are_equal_dictionaries(value_1, value_2)
	else:
		return value_1 == value_2

static func _are_equal_floats(float_1 : float, float_2 : float) -> bool:
	return abs(float_1 - float_2) < JSONProperty.PRECISION_ERROR

static func _are_equal_arrays(array_1 : Array, array_2 : Array) -> bool:
	if array_1.size() != array_2.size():
		return false

	for i in array_1.size():
		if not are_equal(array_1[i], array_2[i]):
			return false
	
	return true

static func _are_equal_dictionaries(dic_1 : Dictionary, dic_2 : Dictionary) -> bool:
	if dic_1.keys().size() != dic_2.keys().size():
		return false

	for key in dic_1.keys():
		if dic_2.has(key):
			if not are_equal(dic_1[key], dic_2[key]):
				return false
		else:
			return false
	
	return true
