static func execute(tests_results):
	var property = JSONPropertyPercentage.new()

	var configuration = JSONConfigFile.new()
	configuration.add_property("percentage", property)

	var case = Case.new()
	case.set_name("Percentage")
	case.set_configuration(configuration)

	var test
	
	test = Test.new()
	test.set_name("\"Test\" is not a percentage")
	test.set_file_path("test/test_files/percentage/Test.json")
	test.set_expected_result({"percentage": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.WRONG_TYPE,
		"expected": JSONProperty.Types.PERCENTAGE,
		"context": "percentage",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("-0.1 is not a percentage")
	test.set_file_path("test/test_files/percentage/-0_1.json")
	test.set_expected_result({"percentage": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.PERCENTAGE_LESS_THAN_ZERO,
		"value": -0.1,
		"context": "percentage",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("0 is a percentage")
	test.set_file_path("test/test_files/percentage/0.json")
	test.set_expected_result({"percentage": 0.0})

	case.add_test(test)

	test = Test.new()
	test.set_name("0.5 is a percentage")
	test.set_file_path("test/test_files/percentage/0_5.json")
	test.set_expected_result({"percentage": 0.5})

	case.add_test(test)

	test = Test.new()
	test.set_name("1 is a percentage")
	test.set_file_path("test/test_files/percentage/1.json")
	test.set_expected_result({"percentage": 1.0})

	case.add_test(test)

	test = Test.new()
	test.set_name("1.1 is not a percentage")
	test.set_file_path("test/test_files/percentage/1_1.json")
	test.set_expected_result({"percentage": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.PERCENTAGE_MORE_THAN_ONE,
		"value": 1.1,
		"context": "percentage",
	})

	case.add_test(test)

	case.check_tests(tests_results)
