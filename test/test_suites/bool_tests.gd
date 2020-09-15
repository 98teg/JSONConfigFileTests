static func execute(tests_results):
	var property = JSONPropertyBool.new()

	var configuration = JSONConfigFile.new()
	configuration.add_property("bool", property)

	var case = Case.new()
	case.set_name("Bool")
	case.set_configuration(configuration)

	var test

	test = Test.new()
	test.set_name("123 is not a boolean")
	test.set_file_path("test/test_files/bool/123.json")
	test.set_expected_result({"bool": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.WRONG_TYPE,
		"expected": JSONProperty.Types.BOOL,
		"context": "bool",
		"as_text": "Wrong type: expected 'boolean', at 'bool'.",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("'true' is a boolean")
	test.set_file_path("test/test_files/bool/true.json")
	test.set_expected_result({"bool": true})

	case.add_test(test)

	test = Test.new()
	test.set_name("'false' is a boolean")
	test.set_file_path("test/test_files/bool/false.json")
	test.set_expected_result({"bool": false})

	case.add_test(test)

	case.check_tests(tests_results)
