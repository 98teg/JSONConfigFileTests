static func execute(tests_results):
	var property = JSONPropertyInteger.new()
	property.set_min_value(-2)
	property.set_max_value(3)

	var configuration = JSONConfigFile.new()
	configuration.add_property("integer", property)

	var case = Case.new()
	case.set_name("Integer with range [-2, 3]")
	case.set_configuration(configuration)

	var test
	
	test = Test.new()
	test.set_name("\"Test\" is not an integer")
	test.set_file_path("test/test_files/integer/Test.json")
	test.set_expected_result({"integer": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.WRONG_TYPE,
		"expected": JSONProperty.Types.INTEGER,
		"context": "integer",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("3.14 is not an integer")
	test.set_file_path("test/test_files/integer/3_14.json")
	test.set_expected_result({"integer": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.WRONG_TYPE,
		"expected": JSONProperty.Types.INTEGER,
		"context": "integer",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("-3 is outside of the range")
	test.set_file_path("test/test_files/integer/-3.json")
	test.set_expected_result({"integer": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.NUMBER_VALUE_LESS_THAN_MIN,
		"min": -2,
		"value": -3,
		"context": "integer",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("-2 is inside of the range")
	test.set_file_path("test/test_files/integer/-2.json")
	test.set_expected_result({"integer": -2})

	case.add_test(test)

	test = Test.new()
	test.set_name("1 is inside of the range")
	test.set_file_path("test/test_files/integer/1.json")
	test.set_expected_result({"integer": 1})

	case.add_test(test)

	test = Test.new()
	test.set_name("3 is inside of the range")
	test.set_file_path("test/test_files/integer/3.json")
	test.set_expected_result({"integer": 3})

	case.add_test(test)

	test = Test.new()
	test.set_name("4 is outside of the range")
	test.set_file_path("test/test_files/integer/4.json")
	test.set_expected_result({"integer": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.NUMBER_VALUE_MORE_THAN_MAX,
		"max": 3,
		"value": 4,
		"context": "integer",
	})

	case.add_test(test)

	case.check_tests(tests_results)
