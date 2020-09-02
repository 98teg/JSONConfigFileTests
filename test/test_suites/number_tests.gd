static func execute(tests_results):
	var property = JSONPropertyNumber.new()
	property.set_min_value(-2)
	property.set_max_value(3)

	var configuration = JSONConfigFile.new()
	configuration.add_property("number", property)

	var case = Case.new()
	case.set_name("Number with range [-2, 3]")
	case.set_configuration(configuration)

	var test
	
	test = Test.new()
	test.set_name("\"Test\" is not a number")
	test.set_file_path("test/test_files/number/Test.json")
	test.set_expected_result({"number": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.WRONG_TYPE,
		"expected": JSONProperty.Types.NUMBER,
		"context": "number",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("0.5 is a number")
	test.set_file_path("test/test_files/number/0_5.json")
	test.set_expected_result({"number": 0.5})

	case.add_test(test)

	test = Test.new()
	test.set_name("-3 is outside of the range")
	test.set_file_path("test/test_files/number/-3.json")
	test.set_expected_result({"number": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.NUMBER_VALUE_LESS_THAN_MIN,
		"min": -2.0,
		"value": -3.0,
		"context": "number",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("-2 is inside of the range")
	test.set_file_path("test/test_files/number/-2.json")
	test.set_expected_result({"number": -2.0})

	case.add_test(test)

	test = Test.new()
	test.set_name("1 is inside of the range")
	test.set_file_path("test/test_files/number/1.json")
	test.set_expected_result({"number": 1.0})

	case.add_test(test)

	test = Test.new()
	test.set_name("3 is inside of the range")
	test.set_file_path("test/test_files/number/3.json")
	test.set_expected_result({"number": 3.0})

	case.add_test(test)

	test = Test.new()
	test.set_name("4 is outside of the range")
	test.set_file_path("test/test_files/number/4.json")
	test.set_expected_result({"number": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.NUMBER_VALUE_MORE_THAN_MAX,
		"max": 3.0,
		"value": 4.0,
		"context": "number",
	})

	case.add_test(test)

	case.check_tests(tests_results)
