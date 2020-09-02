static func execute(tests_results):
	var property = JSONPropertyString.new()
	property.set_min_length(2)
	property.set_max_length(4)
	property.set_pattern("^[a-zA-Z]+$")

	var configuration = JSONConfigFile.new()
	configuration.add_property("string", property)

	var case = Case.new()
	case.set_name("String with length [2,4] and only letters")
	case.set_configuration(configuration)

	var test

	test = Test.new()
	test.set_name("4 is not a string")
	test.set_file_path("test/test_files/string_4.json")
	test.set_expected_result({"string": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.WRONG_TYPE,
		"expected": JSONProperty.Types.STRING,
		"context": "string"
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("\"A\" is shorter than expected")
	test.set_file_path("test/test_files/string_A.json")
	test.set_expected_result({"string": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.STRING_SHORTER_THAN_MIN,
		"min": 2,
		"length": 1,
		"context": "string",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("\"AB\" is valid")
	test.set_file_path("test/test_files/string_AB.json")
	test.set_expected_result({"string": "AB"})

	case.add_test(test)

	test = Test.new()
	test.set_name("\"ABC\" is valid")
	test.set_file_path("test/test_files/string_ABC.json")
	test.set_expected_result({"string": "ABC"})

	case.add_test(test)

	test = Test.new()
	test.set_name("\"ABCD\" is valid")
	test.set_file_path("test/test_files/string_ABCD.json")
	test.set_expected_result({"string": "ABCD"})

	case.add_test(test)

	test = Test.new()
	test.set_name("\"ABCDE\" is longer than expected")
	test.set_file_path("test/test_files/string_ABCDE.json")
	test.set_expected_result({"string": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.STRING_LONGER_THAN_MAX,
		"max": 4,
		"length": 5,
		"context": "string",
	})

	case.add_test(test)

	test = Test.new()
	test.set_name("\"AB1\" contains numbers")
	test.set_file_path("test/test_files/string_AB1.json")
	test.set_expected_result({"string": null})
	test.add_expected_error({
		"error": JSONProperty.Errors.STRING_DO_NOT_MATCH_PATTERN,
		"pattern": "^[a-zA-Z]+$",
		"value": "AB1",
		"context": "string",
	})

	case.add_test(test)

	case.check_tests(tests_results)
