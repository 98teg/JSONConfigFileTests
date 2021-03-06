extends Control

func _ready():
	var tests_results = get_node("ResultsScroller/TestsResults")
	tests_results.create_item()
	tests_results.set_column_min_width(0, 57)
	tests_results.set_column_expand(0, false)

	preload("res://test/test_suites/basic_tests.gd").execute(tests_results)
	preload("res://test/test_suites/bool_tests.gd").execute(tests_results)
	preload("res://test/test_suites/number_tests.gd").execute(tests_results)
	preload("res://test/test_suites/integer_tests.gd").execute(tests_results)
	preload("res://test/test_suites/percentage_tests.gd").execute(tests_results)
	preload("res://test/test_suites/string_tests.gd").execute(tests_results)
	preload("res://test/test_suites/enum_tests.gd").execute(tests_results)
	preload("res://test/test_suites/array_tests.gd").execute(tests_results)
	preload("res://test/test_suites/color_tests.gd").execute(tests_results)
	preload("res://test/test_suites/object_tests.gd").execute(tests_results)
	preload("res://test/test_suites/file_tests.gd").execute(tests_results)
	preload("res://test/test_suites/json_config_file_tests.gd").execute(tests_results)
	preload("res://test/test_suites/image_tests.gd").execute(tests_results)
	preload("res://test/test_suites/processor_tests.gd").execute(tests_results)
