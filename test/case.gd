class_name Case

var _name : String = ""
var _config_file : JSONConfigFile = JSONConfigFile.new()
var _tests : Array = []

func set_name(name : String):
	_name = name

func get_name() -> String:
	return _name

func set_configuration(config_file : JSONConfigFile):
	_config_file = config_file

func add_test(test : Test):
	_tests.append(test)

func check_tests(results_tree : Tree) -> void:
	var results_root = results_tree.create_item(results_tree.get_root())
	results_root.set_collapsed(true)
	results_root.set_text_align(0, TreeItem.ALIGN_RIGHT)

	var correct_tests = 0
	for test in _tests:
		var results_child = results_tree.create_item(results_root)
		results_child.set_text(1, test.get_name())
		results_child.set_text_align(0, TreeItem.ALIGN_RIGHT)

		if test.check(_config_file):
			correct_tests += 1
			results_child.set_text(0, "[OK]")
			results_child.set_custom_color(0, Color.green)
		else:
			results_child.set_text(0, "[ERR]")
			results_child.set_custom_color(0, Color.red)

	results_root.set_text(0, "[%d/%d]" % [correct_tests, _tests.size()])
	results_root.set_text(1, "%s" % get_name())

	if correct_tests == _tests.size():
		results_root.set_custom_color(0, Color.green)
	else:
		results_root.set_custom_color(0, Color.red)
