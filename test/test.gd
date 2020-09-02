class_name Test

var _name : String = ""
var _file_path : String = ""
var _expected_result : Dictionary = {}
var _expected_errors : Array = []

func set_name(name : String):
	_name = name

func get_name() -> String:
	return _name

func set_file_path(file_path : String):
	_file_path = file_path

func set_expected_result(expected_result : Dictionary):
	_expected_result = expected_result

func add_expected_error(expected_error : Dictionary):
	_expected_errors.append(expected_error)

func check(config_file : JSONConfigFile) -> bool:
	config_file.validate(_file_path)

	if not Comparator.are_equal(_expected_result, config_file.get_result()):
		print(config_file.get_result())
		return false

	if not Comparator.are_equal(_expected_errors, config_file.get_errors()):
		print(config_file.get_errors())
		return false

	return true
